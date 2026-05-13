import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:handyman/features/auth/data/models/user_model.dart';
import 'package:handyman/features/auth/domain/entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel?> getCurrentUser();
  Future<UserModel> signInWithPhone(String verificationId, String smsCode, UserRole role);
  Future<void> signInWithGoogle(UserRole role);
  Future<void> signOut();
  Stream<UserModel?> authStateChanges();
  Future<void> sendOTP(String phoneNumber, {required Function(String) onCodeSent});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required this.auth,
    required this.firestore,
  });

  final firebase_auth.FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = auth.currentUser;
    if (user == null) return null;
    
    // First check users collection
    var doc = await firestore.collection('users').doc(user.uid).get();
    if (doc.exists) return UserModel.fromFirestore(doc);
    
    // Fallback to handymen collection
    doc = await firestore.collection('handymen').doc(user.uid).get();
    if (doc.exists) return UserModel.fromFirestore(doc);
    
    return null;
  }

  @override
  Stream<UserModel?> authStateChanges() {
    return auth.authStateChanges().asyncMap((user) async {
      if (user == null) return null;
      
      // First check users collection
      var doc = await firestore.collection('users').doc(user.uid).get();
      if (doc.exists) return UserModel.fromFirestore(doc);
      
      // Fallback to handymen collection
      doc = await firestore.collection('handymen').doc(user.uid).get();
      if (doc.exists) return UserModel.fromFirestore(doc);
      
      return null;
    });
  }

  @override
  Future<void> sendOTP(String phoneNumber, {required Function(String) onCodeSent}) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (firebase_auth.PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (firebase_auth.FirebaseAuthException e) {
        throw e;
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Normal timeout
      },
    );
  }

  @override
  Future<UserModel> signInWithPhone(String verificationId, String smsCode, UserRole role) async {
    final credential = firebase_auth.PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    final userCredential = await auth.signInWithCredential(credential);
    final user = userCredential.user!;
    return _createOrUpdateUser(user, role);
  }

  @override
  Future<void> signInWithGoogle(UserRole role) async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) throw Exception('Google sign in cancelled');
    final googleAuth = await googleUser.authentication;
    final credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final userCredential = await auth.signInWithCredential(credential);
    final user = userCredential.user!;
    await _createOrUpdateUser(user, role);
  }

  @override
  Future<void> signOut() async {
    await googleSignIn.signOut();
    await auth.signOut();
  }

  Future<UserModel> _createOrUpdateUser(firebase_auth.User user, UserRole role) async {
    final docRef = firestore.collection('users').doc(user.uid);
    final doc = await docRef.get();

    if (!doc.exists) {
      final userModel = UserModel(
        uid: user.uid,
        name: user.displayName ?? 'User',
        email: user.email ?? '',
        phone: user.phoneNumber ?? '',
        photoUrl: user.photoURL,
        role: role,
        createdAt: DateTime.now(),
        referralCode: _generateReferralCode(),
      );
      await docRef.set(userModel.toJson());
      return userModel;
    } else {
      return UserModel.fromFirestore(doc);
    }
  }

  String _generateReferralCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(6, (index) => chars[random.nextInt(chars.length)]).join();
  }
}

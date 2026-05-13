import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/features/auth/data/models/user_model.dart';
import 'package:customer/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel?> getCurrentUser();
  Future<UserModel> signInWithPhone(String verificationId, String smsCode);
  Future<UserModel> signInWithGoogle();
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

  String? _storedVerificationId;
  int? _resendToken;

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = auth.currentUser;
    if (user == null) return null;
    final doc = await firestore.collection('customers').doc(user.uid).get();
    if (!doc.exists) return null;
    return UserModel.fromFirestore(doc);
  }

  @override
  Stream<UserModel?> authStateChanges() {
    return auth.authStateChanges().asyncMap((user) async {
      if (user == null) return null;
      final doc = await firestore.collection('customers').doc(user.uid).get();
      if (!doc.exists) return null;
      return UserModel.fromFirestore(doc);
    });
  }

  @override
  Future<void> sendOTP(String phoneNumber, {required Function(String) onCodeSent}) async {
    if (kDebugMode) {
      debugPrint('🔥 sendOTP called with: $phoneNumber');
    }
    
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      forceResendingToken: _resendToken,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        if (kDebugMode) {
          debugPrint('✅ verificationCompleted fired — auto sign in');
        }
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (kDebugMode) {
          debugPrint('❌ verificationFailed fired — code: ${e.code}, message: ${e.message}');
        }
        throw e;
      },
      codeSent: (String verificationId, int? resendToken) {
        if (kDebugMode) {
          debugPrint('📱 codeSent fired — verificationId: $verificationId');
        }
        _storedVerificationId = verificationId;
        _resendToken = resendToken;
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        if (kDebugMode) {
          debugPrint('⏱ codeAutoRetrievalTimeout fired');
        }
        _storedVerificationId = verificationId;
      },
    );
  }

  @override
  Future<UserModel> signInWithPhone(String verificationId, String smsCode) async {
    final vid = verificationId.isNotEmpty ? verificationId : (_storedVerificationId ?? '');
    final credential = PhoneAuthProvider.credential(
      verificationId: vid,
      smsCode: smsCode,
    );
    final userCredential = await auth.signInWithCredential(credential);
    final user = userCredential.user!;
    return _createOrUpdateUser(user, 'phone');
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) throw Exception('Google sign in cancelled');
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final userCredential = await auth.signInWithCredential(credential);
    final user = userCredential.user!;
    return _createOrUpdateUser(user, 'google');
  }

  @override
  Future<void> signOut() async {
    await googleSignIn.signOut();
    await auth.signOut();
  }

  Future<UserModel> _createOrUpdateUser(firebase_auth.User user, String provider) async {
    final docRef = firestore.collection('customers').doc(user.uid);
    final doc = await docRef.get();

    if (!doc.exists) {
      final userModel = UserModel(
        uid: user.uid,
        fullName: user.displayName,
        email: user.email,
        phone: user.phoneNumber,
        photoUrl: user.photoURL,
        role: UserRole.customer,
        isProfileComplete: false,
        isBlocked: false,
        isDeleted: false,
        authProvider: provider,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
        referralCode: _generateReferralCode(),
      );
      await docRef.set(userModel.toJson());
      return userModel;
    } else {
      // Update last login
      await docRef.update({
        'lastLoginAt': FieldValue.serverTimestamp(),
      });
      final updatedDoc = await docRef.get();
      return UserModel.fromFirestore(updatedDoc);
    }
  }

  String _generateReferralCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(6, (index) => chars[random.nextInt(chars.length)]).join();
  }
}

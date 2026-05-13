import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/core/providers/firebase_providers.dart';
import 'package:handyman/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:handyman/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:handyman/features/auth/data/models/user_model.dart';
import 'package:handyman/features/auth/domain/entities/user_entity.dart';
import 'package:handyman/features/auth/domain/repositories/auth_repository.dart';

final authDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(
    auth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(firestoreProvider),
  );
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authDataSourceProvider),
    role: UserRole.handyman,
  );
});

class AuthNotifier extends AsyncNotifier<UserEntity?> {
  String? _verificationId;
  bool _isOtpSent = false;
  bool _isNewUser = false;

  String? get verificationId => _verificationId;
  bool get isOtpSent => _isOtpSent;
  bool get isNewUser => _isNewUser;

  void resetOtpSentFlag() {
    _isOtpSent = false;
  }

  @override
  FutureOr<UserEntity?> build() async {
    final repository = ref.watch(authRepositoryProvider);
    
    repository.authStateChanges().listen((user) async {
      if (user != null) {
        _isOtpSent = false;
        _verificationId = null;
        // Check if profile exists
        await checkIfNewUser(user.uid);
      } else {
        _isNewUser = false;
      }
      state = AsyncData(user);
    });

    final user = await repository.getCurrentUser();
    if (user != null) {
      await checkIfNewUser(user.uid);
    }
    return user;
  }

  Future<void> checkIfNewUser(String uid) async {
    final firestore = ref.read(firestoreProvider);
    final doc = await firestore.collection('handymen').doc(uid).get();
    
    if (doc.exists) {
      final data = doc.data()!;
      final name = data['name']?.toString() ?? '';
      _isNewUser = name.isEmpty;
    } else {
      // Fallback: check by phone number if UID not found
      final user = ref.read(firebaseAuthProvider).currentUser;
      final phone = user?.phoneNumber;
      
      if (phone != null) {
        final query = await firestore
          .collection('handymen')
          .where('phone', isEqualTo: phone)
          .limit(1)
          .get();
        
        if (query.docs.isNotEmpty) {
          _isNewUser = false;
          debugPrint('🔍 Found existing handyman by phone: $phone');
        } else {
          _isNewUser = true;
        }
      } else {
        _isNewUser = true;
      }
    }
    debugPrint('🔍 Check if new user: uid=$uid, isNewUser=$_isNewUser');
  }

  Future<void> completeRegistration({
    required String name,
    required List<String> skills,
    required String serviceArea,
    File? photo,
    required File idProof,
  }) async {
    final user = state.value;
    if (user == null) return;

    state = const AsyncLoading();
    try {
      final firestore = ref.read(firestoreProvider);
      final storage = ref.read(firebaseStorageProvider);
      final messaging = ref.read(firebaseMessagingProvider);
      
      String photoUrl = '';
      if (photo != null) {
        final photoRef = storage.ref().child('handymen/${user.uid}/profile/photo.jpg');
        await photoRef.putFile(photo);
        photoUrl = await photoRef.getDownloadURL();
      }

      final idProofRef = storage.ref().child('handymen/${user.uid}/documents/id_proof.jpg');
      await idProofRef.putFile(idProof);
      final idProofUrl = await idProofRef.getDownloadURL();

      final fcmToken = await messaging.getToken() ?? '';

      // 1. Update user collection
      await firestore.collection('users').doc(user.uid).set({
        'name': name,
        'phone': user.phone,
        'role': 'handyman',
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // 2. Create/Update handyman profile
      await firestore.collection('handymen').doc(user.uid).set({
        'uid': user.uid,
        'name': name,
        'phone': user.phone,
        'skills': skills,
        'serviceArea': serviceArea,
        'photoUrl': photoUrl,
        'idProofUrl': idProofUrl,
        'onboardingStatus': 'pending',
        'isApproved': false,
        'isActive': false,
        'commissionRate': 0,
        'walletBalance': 0,
        'totalEarnings': 0,
        'completedJobs': 0,
        'rating': 0.0,
        'reviewCount': 0,
        'fcmToken': fcmToken,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      _isNewUser = false;
      // Refresh user state
      final updatedDoc = await firestore.collection('handymen').doc(user.uid).get();
      final updatedUser = UserModel.fromFirestore(updatedDoc).toEntity();
      state = AsyncData(updatedUser);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> sendOTP(String phoneNumber) async {
    state = const AsyncLoading();
    try {
      await ref.read(authRepositoryProvider).sendOTP(
        phoneNumber,
        onCodeSent: (String verificationId) {
          _verificationId = verificationId;
          _isOtpSent = true;
          state = const AsyncData(null);
        },
      );
    } on FirebaseAuthException catch (e, st) {
      _isOtpSent = false;
      state = AsyncError(e.message ?? 'Failed to send OTP', st);
    } catch (e, st) {
      _isOtpSent = false;
      state = AsyncError(e, st);
    }
  }

  Future<void> verifyOTP(String verificationId, String smsCode) async {
    state = const AsyncLoading();
    try {
      final user = await ref.read(authRepositoryProvider).signInWithPhone(verificationId, smsCode);
      _isOtpSent = false;
      _verificationId = null;
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    try {
      await ref.read(authRepositoryProvider).signInWithGoogle();
      final user = await ref.read(authRepositoryProvider).getCurrentUser();
      _isOtpSent = false;
      _verificationId = null;
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    try {
      await ref.read(authRepositoryProvider).signOut();
      _isOtpSent = false;
      _verificationId = null;
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, UserEntity?>(AuthNotifier.new);

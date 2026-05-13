import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/core/providers/firebase_providers.dart';
import 'package:provider/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:provider/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:provider/features/auth/domain/entities/user_entity.dart';
import 'package:provider/features/auth/domain/repositories/auth_repository.dart';

final authDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(
    auth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(firestoreProvider),
  );
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authDataSourceProvider),
    role: UserRole.provider,
  );
});

class AuthNotifier extends AsyncNotifier<UserEntity?> {
  String? _verificationId;
  bool _isOtpSent = false;

  String? get verificationId => _verificationId;
  bool get isOtpSent => _isOtpSent;

  void resetOtpSentFlag() {
    _isOtpSent = false;
  }

  @override
  FutureOr<UserEntity?> build() async {
    final repository = ref.watch(authRepositoryProvider);
    
    repository.authStateChanges().listen((user) {
      if (user != null) {
        _isOtpSent = false;
        _verificationId = null;
      }
      state = AsyncData(user);
    });

    return repository.getCurrentUser();
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

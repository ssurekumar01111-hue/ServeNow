import 'package:provider/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> getCurrentUser();
  Future<UserEntity> signInWithPhone(String verificationId, String smsCode);
  Future<void> signInWithGoogle();
  Future<void> signOut();
  Stream<UserEntity?> authStateChanges();
  Future<void> sendOTP(String phoneNumber, {required Function(String) onCodeSent});
}

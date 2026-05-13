import 'package:handyman/features/auth/domain/entities/user_entity.dart';
import 'package:handyman/features/auth/domain/repositories/auth_repository.dart';

class SignInWithPhone {
  SignInWithPhone(this.repository);
  final AuthRepository repository;

  Future<UserEntity> call(String verificationId, String smsCode) =>
      repository.signInWithPhone(verificationId, smsCode);
}

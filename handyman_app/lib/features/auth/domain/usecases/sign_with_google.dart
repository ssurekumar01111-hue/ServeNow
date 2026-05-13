import 'package:handyman/features/auth/domain/repositories/auth_repository.dart';

class SignInWithGoogle {
  SignInWithGoogle(this.repository);
  final AuthRepository repository;

  Future<void> call() => repository.signInWithGoogle();
}

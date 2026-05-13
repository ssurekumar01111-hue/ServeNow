import 'package:customer/features/auth/domain/repositories/auth_repository.dart';

class SignOut {
  SignOut(this.repository);
  final AuthRepository repository;

  Future<void> call() => repository.signOut();
}

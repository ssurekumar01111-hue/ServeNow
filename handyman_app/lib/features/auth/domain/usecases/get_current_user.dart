import 'package:handyman/features/auth/domain/entities/user_entity.dart';
import 'package:handyman/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUser {
  GetCurrentUser(this.repository);
  final AuthRepository repository;

  Future<UserEntity?> call() => repository.getCurrentUser();
}

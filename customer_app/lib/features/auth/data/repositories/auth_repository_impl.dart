import 'package:customer/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:customer/features/auth/domain/entities/user_entity.dart';
import 'package:customer/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.remoteDataSource,
  });

  final AuthRemoteDataSource remoteDataSource;

  @override
  Future<UserEntity?> getCurrentUser() async {
    final userModel = await remoteDataSource.getCurrentUser();
    return userModel?.toEntity();
  }

  @override
  Stream<UserEntity?> authStateChanges() {
    return remoteDataSource.authStateChanges().map((userModel) => userModel?.toEntity());
  }

  @override
  Future<void> sendOTP(String phoneNumber, {required Function(String) onCodeSent}) {
    return remoteDataSource.sendOTP(phoneNumber, onCodeSent: onCodeSent);
  }

  @override
  Future<UserEntity> signInWithPhone(String verificationId, String smsCode) async {
    final userModel = await remoteDataSource.signInWithPhone(verificationId, smsCode);
    return userModel.toEntity();
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    final userModel = await remoteDataSource.signInWithGoogle();
    return userModel.toEntity();
  }

  @override
  Future<void> signOut() {
    return remoteDataSource.signOut();
  }
}

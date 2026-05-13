import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

enum UserRole { customer, provider, handyman, admin }

@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String uid,
    required UserRole role,
    String? name,
    String? phone,
    String? email,
    String? photoUrl,
    @Default(true) bool isActive,
    String? fcmToken,
    DateTime? createdAt,
    String? walletId,
    String? referralCode,
    AddressEntity? address,
    @Default(0.0) double rating,
    @Default(0) int totalRatings,
  }) = _UserEntity;

  const UserEntity._();
}

@freezed
abstract class AddressEntity with _$AddressEntity {
  const factory AddressEntity({
    String? street,
    String? city,
    String? state,
    double? lat,
    double? lng,
    String? pincode,
  }) = _AddressEntity;

  const AddressEntity._();
}

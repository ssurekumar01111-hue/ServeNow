import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

enum UserRole { customer, provider, handyman, admin }

@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String uid,
    UserRole? role,
    String? fullName,
    String? phone,
    String? email,
    String? photoUrl,
    bool? isProfileComplete,
    bool? isBlocked,
    bool? isDeleted,
    String? defaultAddressId,
    String? fcmToken,
    String? authProvider, // 'phone' | 'google'
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLoginAt,
    String? walletId,
    String? referralCode,
  }) = _UserEntity;

  const UserEntity._();
}

@freezed
abstract class AddressEntity with _$AddressEntity {
  const factory AddressEntity({
    String? id,
    String? label, // 'Home' | 'Work' | 'Other'
    String? fullAddress,
    String? area,
    String? city,
    String? state,
    double? lat,
    double? lng,
    String? pincode,
    bool? isDefault,
    DateTime? createdAt,
  }) = _AddressEntity;

  const AddressEntity._();
}

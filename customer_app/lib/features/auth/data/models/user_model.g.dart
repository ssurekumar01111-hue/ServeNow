// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  uid: json['uid'] as String,
  role:
      $enumDecodeNullable(_$UserRoleEnumMap, json['role']) ?? UserRole.customer,
  fullName: json['fullName'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  photoUrl: json['photoUrl'] as String?,
  isProfileComplete: json['isProfileComplete'] as bool? ?? false,
  isBlocked: json['isBlocked'] as bool? ?? false,
  isDeleted: json['isDeleted'] as bool? ?? false,
  defaultAddressId: json['defaultAddressId'] as String?,
  fcmToken: json['fcmToken'] as String?,
  authProvider: json['authProvider'] as String?,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  lastLoginAt: const TimestampConverter().fromJson(json['lastLoginAt']),
  walletId: json['walletId'] as String?,
  referralCode: json['referralCode'] as String?,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'role': _$UserRoleEnumMap[instance.role]!,
      'fullName': instance.fullName,
      'phone': instance.phone,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'isProfileComplete': instance.isProfileComplete,
      'isBlocked': instance.isBlocked,
      'isDeleted': instance.isDeleted,
      'defaultAddressId': instance.defaultAddressId,
      'fcmToken': instance.fcmToken,
      'authProvider': instance.authProvider,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'lastLoginAt': const TimestampConverter().toJson(instance.lastLoginAt),
      'walletId': instance.walletId,
      'referralCode': instance.referralCode,
    };

const _$UserRoleEnumMap = {
  UserRole.customer: 'customer',
  UserRole.provider: 'provider',
  UserRole.handyman: 'handyman',
  UserRole.admin: 'admin',
};

_AddressModel _$AddressModelFromJson(Map<String, dynamic> json) =>
    _AddressModel(
      id: json['id'] as String?,
      label: json['label'] as String? ?? 'Home',
      fullAddress: json['fullAddress'] as String?,
      area: json['area'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      pincode: json['pincode'] as String?,
      isDefault: json['isDefault'] as bool? ?? false,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$AddressModelToJson(_AddressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'fullAddress': instance.fullAddress,
      'area': instance.area,
      'city': instance.city,
      'state': instance.state,
      'lat': instance.lat,
      'lng': instance.lng,
      'pincode': instance.pincode,
      'isDefault': instance.isDefault,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };

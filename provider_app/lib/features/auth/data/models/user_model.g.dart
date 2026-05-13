// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  uid: json['uid'] as String,
  role: $enumDecode(_$UserRoleEnumMap, json['role']),
  name: json['name'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  photoUrl: json['photoUrl'] as String?,
  isActive: json['isActive'] as bool? ?? true,
  fcmToken: json['fcmToken'] as String?,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  walletId: json['walletId'] as String?,
  referralCode: json['referralCode'] as String?,
  address: json['address'] == null
      ? null
      : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
  rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
  totalRatings: (json['totalRatings'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'role': _$UserRoleEnumMap[instance.role]!,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'isActive': instance.isActive,
      'fcmToken': instance.fcmToken,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'walletId': instance.walletId,
      'referralCode': instance.referralCode,
      'address': instance.address,
      'rating': instance.rating,
      'totalRatings': instance.totalRatings,
    };

const _$UserRoleEnumMap = {
  UserRole.customer: 'customer',
  UserRole.provider: 'provider',
  UserRole.handyman: 'handyman',
  UserRole.admin: 'admin',
};

_AddressModel _$AddressModelFromJson(Map<String, dynamic> json) =>
    _AddressModel(
      street: json['street'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      pincode: json['pincode'] as String?,
    );

Map<String, dynamic> _$AddressModelToJson(_AddressModel instance) =>
    <String, dynamic>{
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
      'lat': instance.lat,
      'lng': instance.lng,
      'pincode': instance.pincode,
    };

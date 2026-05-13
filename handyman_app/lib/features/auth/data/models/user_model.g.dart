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
  onboardingStatus: json['onboardingStatus'] as String?,
  isApproved: json['isApproved'] as bool? ?? false,
  idProofUrl: json['idProofUrl'] as String?,
  serviceArea: json['serviceArea'] as String?,
  skills: (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList(),
  commissionRate: (json['commissionRate'] as num?)?.toInt() ?? 0,
  walletBalance: (json['walletBalance'] as num?)?.toDouble() ?? 0.0,
  totalEarnings: (json['totalEarnings'] as num?)?.toDouble() ?? 0.0,
  completedJobs: (json['completedJobs'] as num?)?.toInt() ?? 0,
  rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
  reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
  approvedAt: const TimestampConverter().fromJson(json['approvedAt']),
  approvedBy: json['approvedBy'] as String?,
  rejectedAt: const TimestampConverter().fromJson(json['rejectedAt']),
  rejectedBy: json['rejectedBy'] as String?,
  rejectionReason: json['rejectionReason'] as String?,
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
      'onboardingStatus': instance.onboardingStatus,
      'isApproved': instance.isApproved,
      'idProofUrl': instance.idProofUrl,
      'serviceArea': instance.serviceArea,
      'skills': instance.skills,
      'commissionRate': instance.commissionRate,
      'walletBalance': instance.walletBalance,
      'totalEarnings': instance.totalEarnings,
      'completedJobs': instance.completedJobs,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
      'approvedAt': const TimestampConverter().toJson(instance.approvedAt),
      'approvedBy': instance.approvedBy,
      'rejectedAt': const TimestampConverter().toJson(instance.rejectedAt),
      'rejectedBy': instance.rejectedBy,
      'rejectionReason': instance.rejectionReason,
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

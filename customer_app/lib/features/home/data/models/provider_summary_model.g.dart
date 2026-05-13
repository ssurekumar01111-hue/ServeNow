// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProviderSummaryModel _$ProviderSummaryModelFromJson(
  Map<String, dynamic> json,
) => _ProviderSummaryModel(
  id: json['id'] as String,
  businessName: json['businessName'] as String,
  rating: (json['rating'] as num).toDouble(),
  reviewCount: (json['reviewCount'] as num).toInt(),
  photoUrl: json['photoUrl'] as String,
  categories: (json['categories'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  isVerified: json['isVerified'] as bool? ?? false,
  distance: (json['distance'] as num?)?.toDouble(),
  completedJobs: (json['completedJobs'] as num?)?.toInt() ?? 0,
  serviceArea: json['serviceArea'] as String?,
  isActive: json['isActive'] as bool? ?? true,
  onboardingStatus: json['onboardingStatus'] as String?,
);

Map<String, dynamic> _$ProviderSummaryModelToJson(
  _ProviderSummaryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'businessName': instance.businessName,
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
  'photoUrl': instance.photoUrl,
  'categories': instance.categories,
  'isVerified': instance.isVerified,
  'distance': instance.distance,
  'completedJobs': instance.completedJobs,
  'serviceArea': instance.serviceArea,
  'isActive': instance.isActive,
  'onboardingStatus': instance.onboardingStatus,
};

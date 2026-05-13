// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProviderDetailModel _$ProviderDetailModelFromJson(Map<String, dynamic> json) =>
    _ProviderDetailModel(
      id: json['id'] as String,
      businessName: json['businessName'] as String,
      photoUrl: json['photoUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: (json['reviewCount'] as num).toInt(),
      description: json['description'] as String,
      workingHours: json['workingHours'] as Map<String, dynamic>,
      serviceArea: (json['serviceArea'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isVerified: json['isVerified'] as bool? ?? false,
      services:
          (json['services'] as List<dynamic>?)
              ?.map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      gallery:
          (json['gallery'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      coverPhoto: json['coverPhoto'] as String?,
    );

Map<String, dynamic> _$ProviderDetailModelToJson(
  _ProviderDetailModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'businessName': instance.businessName,
  'photoUrl': instance.photoUrl,
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
  'description': instance.description,
  'workingHours': instance.workingHours,
  'serviceArea': instance.serviceArea,
  'isVerified': instance.isVerified,
  'services': instance.services,
  'gallery': instance.gallery,
  'coverPhoto': instance.coverPhoto,
};

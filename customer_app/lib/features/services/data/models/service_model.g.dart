// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) =>
    _ServiceModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      categoryId: json['categoryId'] as String,
      providerId: json['providerId'] as String,
      basePrice: (json['basePrice'] as num).toDouble(),
      duration: (json['duration'] as num).toInt(),
      discountPrice: (json['discountPrice'] as num?)?.toDouble(),
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? true,
      bookingCount: (json['bookingCount'] as num?)?.toInt() ?? 0,
      categoryName: json['categoryName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      providerName: json['providerName'] as String?,
    );

Map<String, dynamic> _$ServiceModelToJson(_ServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'categoryId': instance.categoryId,
      'providerId': instance.providerId,
      'basePrice': instance.basePrice,
      'duration': instance.duration,
      'discountPrice': instance.discountPrice,
      'images': instance.images,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
      'isActive': instance.isActive,
      'bookingCount': instance.bookingCount,
      'categoryName': instance.categoryName,
      'imageUrl': instance.imageUrl,
      'providerName': instance.providerName,
    };

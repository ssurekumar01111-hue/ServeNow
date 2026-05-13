// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReviewEntity _$ReviewEntityFromJson(Map<String, dynamic> json) =>
    _ReviewEntity(
      id: json['id'] as String,
      bookingId: json['bookingId'] as String,
      customerId: json['customerId'] as String,
      customerName: json['customerName'] as String,
      providerId: json['providerId'] as String,
      handymanId: json['handymanId'] as String?,
      providerRating: (json['providerRating'] as num).toDouble(),
      handymanRating: (json['handymanRating'] as num).toDouble(),
      comment: json['comment'] as String?,
      photos:
          (json['photos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isVisible: json['isVisible'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ReviewEntityToJson(_ReviewEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bookingId': instance.bookingId,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'providerId': instance.providerId,
      'handymanId': instance.handymanId,
      'providerRating': instance.providerRating,
      'handymanRating': instance.handymanRating,
      'comment': instance.comment,
      'photos': instance.photos,
      'isVisible': instance.isVisible,
      'createdAt': instance.createdAt.toIso8601String(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BannerModel _$BannerModelFromJson(Map<String, dynamic> json) => _BannerModel(
  id: json['id'] as String,
  title: json['title'] as String,
  subtitle: json['subtitle'] as String,
  imageUrl: json['imageUrl'] as String,
  actionType: json['actionType'] as String,
  actionValue: json['actionValue'] as String,
  sortOrder: (json['sortOrder'] as num).toInt(),
  isActive: json['isActive'] as bool? ?? true,
  targetRoute: json['targetRoute'] as String?,
);

Map<String, dynamic> _$BannerModelToJson(_BannerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'imageUrl': instance.imageUrl,
      'actionType': instance.actionType,
      'actionValue': instance.actionValue,
      'sortOrder': instance.sortOrder,
      'isActive': instance.isActive,
      'targetRoute': instance.targetRoute,
    };

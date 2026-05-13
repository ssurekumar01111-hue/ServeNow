// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    _CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      iconUrl: json['iconUrl'] as String,
      sortOrder: (json['sortOrder'] as num).toInt(),
      isActive: json['isActive'] as bool? ?? true,
      iconName: json['iconName'] as String?,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$CategoryModelToJson(_CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'iconUrl': instance.iconUrl,
      'sortOrder': instance.sortOrder,
      'isActive': instance.isActive,
      'iconName': instance.iconName,
      'color': instance.color,
    };

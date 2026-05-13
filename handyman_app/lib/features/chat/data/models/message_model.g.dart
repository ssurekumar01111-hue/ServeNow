// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageModel _$MessageModelFromJson(Map<String, dynamic> json) =>
    _MessageModel(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      senderRole: json['senderRole'] as String,
      text: json['text'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRead: json['isRead'] as bool,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$MessageModelToJson(_MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'senderRole': instance.senderRole,
      'text': instance.text,
      'createdAt': instance.createdAt.toIso8601String(),
      'isRead': instance.isRead,
      'imageUrl': instance.imageUrl,
    };

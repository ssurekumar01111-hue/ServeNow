import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:customer/features/chat/domain/entities/message_entity.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
abstract class MessageModel with _$MessageModel {
  const factory MessageModel({
    required String id,
    required String senderId,
    required String senderRole,
    required String text,
    String? imageUrl,
    required DateTime createdAt,
    required bool isRead,
  }) = _MessageModel;

  const MessageModel._();

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  factory MessageModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return MessageModel.fromJson({
      'id': doc.id,
      'senderId': (data['senderId'] as String?) ?? '',
      'senderRole': (data['senderRole'] as String?) ?? 'customer',
      'text': (data['text'] as String?) ?? '',
      'imageUrl': data['imageUrl'] as String?,
      'createdAt': (data['createdAt'] as Timestamp?)?.toDate().toIso8601String() ?? DateTime.now().toIso8601String(),
      'isRead': (data['isRead'] as bool?) ?? false,
    });
  }

  MessageEntity toEntity() => MessageEntity(
        id: id,
        senderId: senderId,
        senderRole: senderRole,
        text: text,
        imageUrl: imageUrl,
        createdAt: createdAt,
        isRead: isRead,
      );

  factory MessageModel.fromEntity(MessageEntity entity) => MessageModel(
        id: entity.id,
        senderId: entity.senderId,
        senderRole: entity.senderRole,
        text: entity.text,
        imageUrl: entity.imageUrl,
        createdAt: entity.createdAt,
        isRead: entity.isRead,
      );
}

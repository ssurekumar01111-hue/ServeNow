import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:provider/features/chat/domain/entities/message_entity.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
abstract class MessageModel with _$MessageModel {
  const factory MessageModel({
    required String id,
    required String senderId,
    required String senderRole,
    required String text,
    required DateTime createdAt, required bool isRead, String? imageUrl,
  }) = _MessageModel;

  factory MessageModel.fromEntity(MessageEntity entity) => MessageModel(
        id: entity.id,
        senderId: entity.senderId,
        senderRole: entity.senderRole,
        text: entity.text,
        imageUrl: entity.imageUrl,
        createdAt: entity.createdAt,
        isRead: entity.isRead,
      );

  const MessageModel._();

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  factory MessageModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return MessageModel.fromJson({
      ...data,
      'id': doc.id,
      'createdAt': (data['createdAt'] as Timestamp).toDate().toIso8601String(),
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
}

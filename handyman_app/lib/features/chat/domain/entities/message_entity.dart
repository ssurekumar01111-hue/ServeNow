import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_entity.freezed.dart';

@freezed
abstract class MessageEntity with _$MessageEntity {
  const factory MessageEntity({
    required String id,
    required String senderId,
    required String senderRole,
    required String text,
    required DateTime createdAt, String? imageUrl,
    @Default(false) bool isRead,
  }) = _MessageEntity;

  const MessageEntity._();
}

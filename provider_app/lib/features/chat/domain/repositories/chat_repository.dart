import 'dart:io';

import 'package:provider/features/chat/domain/entities/message_entity.dart';

abstract class ChatRepository {
  Stream<List<MessageEntity>> getMessages(String bookingId);
  Future<void> sendMessage(String bookingId, MessageEntity message);
  Future<String> uploadChatImage(String bookingId, File image);
  Future<void> markAsRead(String bookingId, String messageId);
}

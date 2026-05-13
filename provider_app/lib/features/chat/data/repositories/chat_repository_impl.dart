import 'dart:io';

import 'package:provider/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:provider/features/chat/data/models/message_model.dart';
import 'package:provider/features/chat/domain/entities/message_entity.dart';
import 'package:provider/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this.remoteDataSource);
  final ChatRemoteDataSource remoteDataSource;

  @override
  Stream<List<MessageEntity>> getMessages(String bookingId) {
    return remoteDataSource.getMessages(bookingId).map(
          (models) => models.map((m) => m.toEntity()).toList(),
        );
  }

  @override
  Future<void> sendMessage(String bookingId, MessageEntity message) {
    return remoteDataSource.sendMessage(
      bookingId,
      MessageModel.fromEntity(message),
    );
  }

  @override
  Future<String> uploadChatImage(String bookingId, File image) {
    return remoteDataSource.uploadChatImage(bookingId, image);
  }

  @override
  Future<void> markAsRead(String bookingId, String messageId) {
    return remoteDataSource.markAsRead(bookingId, messageId);
  }
}

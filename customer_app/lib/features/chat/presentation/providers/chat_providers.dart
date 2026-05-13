import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:customer/core/providers/firebase_providers.dart';
import 'package:customer/features/chat/domain/entities/message_entity.dart';
import 'package:customer/features/chat/domain/repositories/chat_repository.dart';
import 'package:customer/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:customer/features/chat/data/repositories/chat_repository_impl.dart';

final chatRemoteDataSourceProvider = Provider<ChatRemoteDataSource>((ref) {
  return ChatRemoteDataSourceImpl(
    ref.watch(firestoreProvider),
    ref.watch(firebaseStorageProvider),
  );
});

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepositoryImpl(ref.watch(chatRemoteDataSourceProvider));
});

final messagesProvider = StreamProvider.family<List<MessageEntity>, String>((ref, bookingId) {
  return ref.watch(chatRepositoryProvider).getMessages(bookingId);
});

final chatNotifierProvider = AsyncNotifierProvider<ChatNotifier, void>(ChatNotifier.new);

class ChatNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> sendTextMessage(String bookingId, String text, String senderId, String senderRole) async {
    final message = MessageEntity(
      id: '',
      senderId: senderId,
      senderRole: senderRole,
      text: text,
      createdAt: DateTime.now(),
    );
    await ref.read(chatRepositoryProvider).sendMessage(bookingId, message);
  }

  Future<void> sendImageMessage(String bookingId, File image, String senderId, String senderRole) async {
    state = const AsyncLoading();
    try {
      final imageUrl = await ref.read(chatRepositoryProvider).uploadChatImage(bookingId, image);
      final message = MessageEntity(
        id: '',
        senderId: senderId,
        senderRole: senderRole,
        text: 'Image',
        imageUrl: imageUrl,
        createdAt: DateTime.now(),
      );
      await ref.read(chatRepositoryProvider).sendMessage(bookingId, message);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> markAsRead(String bookingId, String messageId) async {
    await ref.read(chatRepositoryProvider).markAsRead(bookingId, messageId);
  }
}

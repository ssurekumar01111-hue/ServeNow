import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/features/chat/domain/entities/message_entity.dart';
import 'package:provider/features/chat/presentation/providers/chat_providers.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({
    required this.bookingId,
    required this.otherPartyName,
    this.otherPartyPhoto,
    super.key,
  });

  final String bookingId;
  final String otherPartyName;
  final String? otherPartyPhoto;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _textController = TextEditingController();
  final _picker = ImagePicker();

  void _sendText() {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      final user = ref.read(authNotifierProvider).value!;
      ref.read(chatNotifierProvider.notifier).sendTextMessage(
            widget.bookingId,
            text,
            user.uid,
            user.role.name,
          );
      _textController.clear();
    }
  }

  Future<void> _sendImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final user = ref.read(authNotifierProvider).value!;
      ref.read(chatNotifierProvider.notifier).sendImageMessage(
            widget.bookingId,
            File(pickedFile.path),
            user.uid,
            user.role.name,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(messagesProvider(widget.bookingId));
    final user = ref.watch(authNotifierProvider).value!;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: widget.otherPartyPhoto != null
                  ? NetworkImage(widget.otherPartyPhoto!)
                  : null,
              child: widget.otherPartyPhoto == null ? const Icon(Icons.person) : null,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                widget.otherPartyName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: messagesAsync.when(
              data: (messages) => ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isMe = message.senderId == user.uid;
                  
                  // Mark as read logic could go here or in a wrapper
                  if (!message.isRead && !isMe) {
                    ref.read(chatNotifierProvider.notifier).markAsRead(widget.bookingId, message.id);
                  }

                  return MessageBubble(message: message, isMe: isMe);
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Error: $e')),
            ),
          ),
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(icon: const Icon(Icons.image), onPressed: _sendImage),
            Expanded(
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => _sendText(),
              ),
            ),
            IconButton(icon: const Icon(Icons.send), onPressed: _sendText),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({required this.message, required this.isMe, super.key});
  final MessageEntity message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        decoration: BoxDecoration(
          color: isMe ? Theme.of(context).primaryColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(12).copyWith(
            bottomRight: isMe ? const Radius.circular(0) : null,
            bottomLeft: !isMe ? const Radius.circular(0) : null,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.imageUrl != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(message.imageUrl!),
                ),
              ),
            Text(
              message.text,
              style: TextStyle(color: isMe ? Colors.white : Colors.black87),
            ),
            const SizedBox(height: 2),
            Text(
              '${message.createdAt.hour}:${message.createdAt.minute.toString().padLeft(2, '0')}',
              style: TextStyle(
                fontSize: 10,
                color: isMe ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

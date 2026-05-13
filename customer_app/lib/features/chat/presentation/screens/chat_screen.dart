import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/theme/app_colors.dart';
import 'package:customer/features/auth/presentation/providers/auth_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String bookingId;
  final String otherName;

  const ChatScreen({
    super.key,
    required this.bookingId,
    required this.otherName,
  });

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _markMessagesAsRead();
  }

  void _markMessagesAsRead() async {
    final user = ref.read(authNotifierProvider).value;
    if (user == null) return;

    final unreadMessages = await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.bookingId)
        .collection('messages')
        .where('senderType', isEqualTo: 'handyman')
        .where('isRead', isEqualTo: false)
        .get();

    for (var doc in unreadMessages.docs) {
      doc.reference.update({'isRead': true});
    }
  }

  Future<void> _sendMessage({String? text, String? imageUrl}) async {
    if ((text == null || text.trim().isEmpty) && imageUrl == null) return;

    final user = ref.read(authNotifierProvider).value;
    if (user == null) return;

    setState(() => _isSending = true);

    final chatId = widget.bookingId;
    final messageData = {
      'senderId': user.uid,
      'senderName': user.fullName ?? 'Customer',
      'senderType': 'customer',
      'message': text ?? '',
      'type': imageUrl != null ? 'image' : 'text',
      'imageUrl': imageUrl,
      'isRead': false,
      'sentAt': FieldValue.serverTimestamp(),
    };

    final chatDoc = await FirebaseFirestore.instance.collection('chats').doc(chatId).get();
    
    // Create/Update Chat record
    await FirebaseFirestore.instance.collection('chats').doc(chatId).set({
      'bookingId': widget.bookingId,
      'customerId': user.uid,
      'customerName': user.fullName ?? 'Customer',
      'lastMessage': imageUrl != null ? '📷 Image' : text,
      'lastMessageAt': FieldValue.serverTimestamp(),
      'lastMessageBy': user.uid,
    }, SetOptions(merge: true));

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(messageData);

    _messageController.clear();
    setState(() => _isSending = false);
    _scrollToBottom();

    // FCM Notification will be handled by Cloud Function or we can trigger it here
    // For now, Cloud Functions are preferred as per Step 15
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    setState(() => _isSending = true);
    
    final ref = FirebaseStorage.instance
        .ref()
        .child('chats')
        .child(widget.bookingId)
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

    await ref.putFile(File(image.path));
    final url = await ref.getDownloadURL();
    
    await _sendMessage(imageUrl: url);
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(radius: 16, child: Icon(Icons.person, size: 20)),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.otherName, style: const TextStyle(fontSize: 16)),
                const Text('Online', style: TextStyle(fontSize: 12, color: Colors.green)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone, color: Colors.green),
            onPressed: () => _showCallDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(widget.bookingId)
                  .collection('messages')
                  .orderBy('sentAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                
                final messages = snapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  padding: const EdgeInsets.all(15),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final data = messages[index].data() as Map<String, dynamic>;
                    final isMe = data['senderType'] == 'customer';
                    return _buildMessageBubble(data, isMe);
                  },
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> data, bool isMe) {
    final sentAt = data['sentAt'] as Timestamp?;
    final timeStr = sentAt != null ? DateFormat('HH:mm').format(sentAt.toDate()) : '';
    final type = data['type'] as String? ?? 'text';
    final imageUrl = data['imageUrl'] as String? ?? '';
    final message = data['message'] as String? ?? '';

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primary : Colors.grey.shade200,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: Radius.circular(isMe ? 15 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 15),
          ),
        ),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (type == 'image')
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const SizedBox(
                      width: 200,
                      height: 200,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
              )
            else
              Text(
                message,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black87,
                  fontSize: 15,
                ),
              ),
            const SizedBox(height: 4),
            Text(
              timeStr,
              style: TextStyle(
                color: isMe ? Colors.white70 : Colors.black54,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.image, color: AppColors.primary),
              onPressed: _pickImage,
            ),
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                maxLines: null,
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _isSending ? null : () => _sendMessage(text: _messageController.text),
              child: CircleAvatar(
                backgroundColor: AppColors.primary,
                child: _isSending 
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Icon(Icons.send, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCallDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Call ${widget.otherName}?'),
        content: const Text('Do you want to initiate a voice call?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
            onPressed: () {
              Navigator.pop(context);
              _launchCaller("1234567890"); // Should be dynamic
            },
            child: const Text('Call'),
          ),
        ],
      ),
    );
  }

  void _launchCaller(String phone) async {
    final url = Uri.parse('tel:$phone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}

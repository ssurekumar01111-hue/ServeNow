import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/features/chat/data/models/message_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class ChatRemoteDataSource {
  Stream<List<MessageModel>> getMessages(String bookingId);
  Future<void> sendMessage(String bookingId, MessageModel message);
  Future<String> uploadChatImage(String bookingId, File image);
  Future<void> markAsRead(String bookingId, String messageId);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  ChatRemoteDataSourceImpl(this.firestore, this.storage);
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  @override
  Stream<List<MessageModel>> getMessages(String bookingId) {
    return firestore
        .collection('bookings')
        .doc(bookingId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map(MessageModel.fromFirestore).toList());
  }

  @override
  Future<void> sendMessage(String bookingId, MessageModel message) async {
    final docRef = firestore
        .collection('bookings')
        .doc(bookingId)
        .collection('messages')
        .doc();
    
    final messageWithId = message.copyWith(id: docRef.id);
    await docRef.set({
      ...messageWithId.toJson(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<String> uploadChatImage(String bookingId, File image) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final ref = storage.ref().child('chats/$bookingId/$fileName');
    final uploadTask = await ref.putFile(image);
    return uploadTask.ref.getDownloadURL();
  }

  @override
  Future<void> markAsRead(String bookingId, String messageId) async {
    await firestore
        .collection('bookings')
        .doc(bookingId)
        .collection('messages')
        .doc(messageId)
        .update({'isRead': true});
  }
}

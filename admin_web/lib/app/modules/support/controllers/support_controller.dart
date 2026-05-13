import 'dart:async';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin_web/app/constants/collection_name.dart';

class SupportController extends GetxController {
  final chats = [].obs;
  final selectedChatId = ''.obs;
  final selectedChatMessages = [].obs;
  final selectedChatData = {}.obs;

  StreamSubscription? _chatSub;
  StreamSubscription? _msgSub;

  @override
  void onInit() {
    super.onInit();
    loadChats();
  }

  void loadChats() {
    _chatSub = FirebaseFirestore.instance
        .collection(CollectionName.chats)
        .orderBy('lastMessageAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      chats.value = snapshot.docs.map((doc) {
        var data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
      
      if (selectedChatId.value.isEmpty && chats.isNotEmpty) {
        openChat(chats.first['id']);
      }
    });
  }

  void openChat(String chatId) {
    selectedChatId.value = chatId;
    selectedChatData.value = chats.firstWhere((c) => c['id'] == chatId, orElse: () => {});
    
    _msgSub?.cancel();
    _msgSub = FirebaseFirestore.instance
        .collection(CollectionName.chats)
        .doc(chatId)
        .collection('messages')
        .orderBy('sentAt')
        .snapshots()
        .listen((snapshot) {
      selectedChatMessages.value = snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  void onClose() {
    _chatSub?.cancel();
    _msgSub?.cancel();
    super.onClose();
  }
}

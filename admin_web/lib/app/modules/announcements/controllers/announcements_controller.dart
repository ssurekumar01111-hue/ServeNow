import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_web/app/utils/fire_store_utils.dart';

class AnnouncementsController extends GetxController {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final targetAudience = 'all'.obs;
  final isSending = false.obs;
  final announcements = [].obs;

  StreamSubscription? _sub;

  @override
  void onInit() {
    super.onInit();
    listenToAnnouncements();
  }

  void listenToAnnouncements() {
    _sub = FireStoreUtils.getAnnouncementsStream().listen((snapshot) {
      announcements.value = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  Future<void> sendAnnouncement() async {
    if (titleController.text.isEmpty || bodyController.text.isEmpty) {
      Get.snackbar('Error', 'Title and message body are required.');
      return;
    }

    if (titleController.text.length > 50) {
      Get.snackbar('Error', 'Title must be less than 50 characters.');
      return;
    }

    if (bodyController.text.length > 200) {
      Get.snackbar('Error', 'Message body must be less than 200 characters.');
      return;
    }

    isSending.value = true;
    try {
      await FireStoreUtils.sendAnnouncement(targetAudience.value, titleController.text, bodyController.text);
      titleController.clear();
      bodyController.clear();
      targetAudience.value = 'all';
      Get.snackbar('Success', 'Notification sent successfully.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to send notification: $e');
    } finally {
      isSending.value = false;
    }
  }

  @override
  void onClose() {
    _sub?.cancel();
    titleController.dispose();
    bodyController.dispose();
    super.onClose();
  }
}

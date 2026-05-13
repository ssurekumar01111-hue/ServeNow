import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_web/app/models/handyman_model.dart';
import 'package:admin_web/app/utils/fire_store_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HandymenController extends GetxController {
  final allHandymen = <HandymanModel>[].obs;
  final pendingHandymen = <HandymanModel>[].obs;
  final approvedHandymen = <HandymanModel>[].obs;
  final rejectedHandymen = <HandymanModel>[].obs;
  
  final searchQuery = ''.obs;
  final isLoading = true.obs;
  StreamSubscription? _sub;

  @override
  void onInit() {
    super.onInit();
    listenToHandymen();
  }

  void listenToHandymen() {
    _sub = FireStoreUtils.getHandymenStream().listen((snapshot) {
      allHandymen.value = snapshot.docs
          .map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            data['id'] = doc.id;
            return HandymanModel.fromJson(data);
          })
          .toList();
      applyFilters();
      isLoading.value = false;
    });
  }

  void applyFilters() {
    var filtered = allHandymen.where((handyman) {
      bool matchesSearch = searchQuery.value.isEmpty || 
          (handyman.fullName ?? '').toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          (handyman.phone ?? '').toLowerCase().contains(searchQuery.value.toLowerCase());
      return matchesSearch;
    }).toList();

    pendingHandymen.value = filtered.where((h) => h.onboardingStatus == 'pending').toList();
    approvedHandymen.value = filtered.where((h) => h.onboardingStatus == 'approved' || (h.isApproved == true && h.onboardingStatus == null)).toList();
    rejectedHandymen.value = filtered.where((h) => h.onboardingStatus == 'rejected').toList();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  Future<void> toggleActive(String id, bool isActive) async {
    await FireStoreUtils.toggleHandymanActive(id, isActive);
  }

  Future<void> approveHandyman(String id) async {
    final adminUid = FirebaseAuth.instance.currentUser?.uid ?? '';
    await FireStoreUtils.approveHandyman(id, adminUid);
    Get.snackbar('Success', 'Handyman approved successfully', backgroundColor: Colors.green, colorText: Colors.white);
  }

  Future<void> rejectHandyman(String id, String reason) async {
    final adminUid = FirebaseAuth.instance.currentUser?.uid ?? '';
    await FireStoreUtils.rejectHandyman(id, adminUid, reason);
    Get.snackbar('Rejected', 'Handyman application rejected', backgroundColor: Colors.red, colorText: Colors.white);
  }

  Future<void> updateCommission(String id, int rate) async {
    await FireStoreUtils.updateHandymanCommission(id, rate);
    Get.snackbar('Success', 'Commission rate updated', backgroundColor: Colors.blue, colorText: Colors.white);
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}

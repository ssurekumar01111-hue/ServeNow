import 'dart:async';
import 'package:get/get.dart';
import 'package:admin_web/app/models/admin_model.dart';
import 'package:admin_web/app/utils/fire_store_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class AdminsController extends GetxController {
  final allAdmins = <AdminModel>[].obs;
  final isLoading = true.obs;

  StreamSubscription? _sub;

  @override
  void onInit() {
    super.onInit();
    listenToAdmins();
  }

  void listenToAdmins() {
    _sub = FireStoreUtils.getAdminsStream().listen((snapshot) {
      allAdmins.value = snapshot.docs
          .map((doc) => AdminModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      isLoading.value = false;
    });
  }

  Future<void> saveAdmin(String name, String email, String role) async {
    final newAdmin = AdminModel(
      id: const Uuid().v4(), // In reality, this should be the Firebase Auth UID
      name: name,
      email: email,
      role: role,
      isActive: true,
      createdAt: Timestamp.now(),
    );
    await FireStoreUtils.addAdmin(newAdmin);
  }

  Future<void> toggleActive(String id, bool isActive) async {
    await FireStoreUtils.toggleAdmin(id, isActive);
  }

  Future<void> updateRole(String id, String role) async {
    await FireStoreUtils.updateAdminRole(id, role);
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_web/app/models/service_model.dart';
import 'package:admin_web/app/models/category_model.dart';
import 'package:admin_web/app/utils/fire_store_utils.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServicesController extends GetxController {
  final allServices = <ServiceModel>[].obs;
  final categories = <CategoryModel>[].obs;
  final filteredServices = <ServiceModel>[].obs;
  final selectedCategoryFilter = 'all'.obs;
  final isLoading = true.obs;
  final isSaving = false.obs;

  StreamSubscription? _subServices;
  StreamSubscription? _subCategories;

  @override
  void onInit() {
    super.onInit();
    listenToData();
  }

  void listenToData() {
    _subCategories = FireStoreUtils.getCategoriesStream().listen((snapshot) {
      categories.value = snapshot.docs
          .map((doc) => CategoryModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });

    _subServices = FireStoreUtils.getServicesStream().listen((snapshot) {
      allServices.value = snapshot.docs
          .map((doc) => ServiceModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      applyFilter();
      isLoading.value = false;
    });
  }

  void applyFilter() {
    if (selectedCategoryFilter.value == 'all') {
      filteredServices.value = allServices;
    } else {
      filteredServices.value = allServices
          .where((s) => s.categoryId == selectedCategoryFilter.value)
          .toList();
    }
  }

  void setFilter(String categoryId) {
    selectedCategoryFilter.value = categoryId;
    applyFilter();
  }

  Future<void> saveService(ServiceModel service) async {
    isSaving.value = true;
    try {
      if (allServices.any((s) => s.id == service.id)) {
        await FireStoreUtils.updateService(service.id ?? '', service.toJson());
      } else {
        await FireStoreUtils.addService(service);
      }
      Get.back();
      Get.snackbar('Success', 'Service saved successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> deleteService(String id) async {
    await FireStoreUtils.deleteService(id);
    Get.snackbar('Success', 'Service deleted');
  }

  Future<void> toggleActive(String id, bool isActive) async {
    await FireStoreUtils.toggleService(id, isActive);
  }

  @override
  void onClose() {
    _subServices?.cancel();
    _subCategories?.cancel();
    super.onClose();
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_web/app/models/category_model.dart';
import 'package:admin_web/app/utils/fire_store_utils.dart';
import 'package:uuid/uuid.dart';
import 'package:admin_web/app/constants/collection_name.dart';

class CategoriesController extends GetxController {
  var categories = <CategoryModel>[].obs;
  List<CategoryModel> get allCategories => categories;
  
  var isLoading = true.obs;
  var isAddingCategory = false.obs;

  final nameController = TextEditingController();
  final sortOrderController = TextEditingController();
  final iconNameController = TextEditingController();
  final colorController = TextEditingController();
  final isActive = true.obs;

  StreamSubscription? _sub;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories() {
    isLoading.value = true;
    _sub = FireStoreUtils.getCategoriesStream().listen(
      (snapshot) {
        print('=== CATEGORIES ===');
        print('Collection: ${CollectionName.serviceCategories}');
        print('Total docs: ${snapshot.docs.length}');
        if (snapshot.docs.isNotEmpty) {
          print('First doc data: ${snapshot.docs.first.data()}');
        }
        
        categories.value = snapshot.docs
            .map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              data['id'] = doc.id;
              try {
                return CategoryModel.fromJson(data);
              } catch (e) {
                print('Error parsing category ${doc.id}: $e');
                return null;
              }
            })
            .whereType<CategoryModel>()
            .toList();
        
        isLoading.value = false;
      },
      onError: (error) {
        print('=== CATEGORIES ERROR ===');
        print(error.toString());
        isLoading.value = false;
      },
    );
  }

  Future<void> saveCategory({String? id}) async {
    isAddingCategory.value = true;
    try {
      final cat = CategoryModel(
        id: id ?? const Uuid().v4(),
        name: nameController.text,
        sortOrder: int.tryParse(sortOrderController.text) ?? 0,
        isActive: isActive.value,
        iconName: iconNameController.text,
        color: colorController.text,
      );

      if (id == null) {
        await FireStoreUtils.addCategory(cat);
      } else {
        await FireStoreUtils.updateCategory(id, cat.toJson());
      }
      clearControllers();
      Get.back();
    } finally {
      isAddingCategory.value = false;
    }
  }

  Future<void> deleteCategory(String id) async {
    await FireStoreUtils.deleteCategory(id);
  }

  void resetForm() {
    clearControllers();
  }

  void clearControllers() {
    nameController.clear();
    sortOrderController.text = '0';
    iconNameController.text = 'home';
    colorController.text = '#000000';
    isActive.value = true;
  }

  @override
  void onClose() {
    _sub?.cancel();
    nameController.dispose();
    sortOrderController.dispose();
    iconNameController.dispose();
    colorController.dispose();
    super.onClose();
  }
}

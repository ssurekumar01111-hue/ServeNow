import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_web/app/modules/categories/controllers/categories_controller.dart';
import 'package:admin_web/widgets/main_layout.dart';
import 'package:admin_web/widgets/confirm_dialog_widget.dart';
import 'package:admin_web/app/utils/app_colors.dart';
import 'package:admin_web/app/models/category_model.dart';

class CategoriesView extends GetView<CategoriesController> {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Categories',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Manage Categories', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                onPressed: () {
                  controller.resetForm();
                  _showAddEditModal(context);
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Category'),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.allCategories.isEmpty) {
              return const Center(child: Text('No categories found.'));
            }
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 1100 ? 4 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
              ),
              itemCount: controller.allCategories.length,
              itemBuilder: (context, index) {
                final cat = controller.allCategories[index];
                return _buildCategoryCard(context, cat);
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, CategoryModel cat) {
    Color cardColor = Colors.black;
    try {
      if (cat.color != null && cat.color!.startsWith('#')) {
        cardColor = Color(int.parse(cat.color!.replaceFirst('#', '0xff')));
      }
    } catch (e) {
      cardColor = Colors.black;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: cardColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.category, color: cardColor),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 18, color: AppColors.textSecondary),
                    onPressed: () {
                      controller.nameController.text = cat.name ?? '';
                      controller.sortOrderController.text = (cat.sortOrder ?? 0).toString();
                      controller.iconNameController.text = cat.iconName ?? 'home';
                      controller.colorController.text = cat.color ?? '#000000';
                      controller.isActive.value = cat.isActive ?? true;
                      _showAddEditModal(context, categoryId: cat.id);
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.error),
                    onPressed: () {
                      if (cat.id != null) {
                        showDialog(
                          context: context,
                          builder: (context) => ConfirmDialogWidget(
                            title: 'Delete Category',
                            message: 'Are you sure you want to delete ${cat.name ?? ''}?',
                            confirmColor: AppColors.error,
                            confirmText: 'Delete',
                            onConfirm: () => controller.deleteCategory(cat.id!),
                          ),
                        );
                      }
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Text(cat.name ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text('Icon: ${cat.iconName ?? 'home'}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Order: ${cat.sortOrder ?? 0}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              const SizedBox(width: 8),
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: (cat.isActive ?? false) ? AppColors.success : AppColors.error,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text((cat.isActive ?? false) ? 'Active' : 'Inactive', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddEditModal(BuildContext context, {String? categoryId}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(categoryId == null ? 'Add Category' : 'Edit Category'),
          content: SizedBox(
            width: 400,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller.nameController,
                    decoration: const InputDecoration(labelText: 'Category Name', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: controller.sortOrderController,
                    decoration: const InputDecoration(labelText: 'Sort Order', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: controller.iconNameController,
                    decoration: const InputDecoration(labelText: 'Icon Name (e.g. plumbing)', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: controller.colorController,
                    decoration: const InputDecoration(labelText: 'Color Hex (e.g. #FF0000)', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 16),
                  Obx(() => SwitchListTile(
                    title: const Text('Active'),
                    value: controller.isActive.value,
                    onChanged: (val) => controller.isActive.value = val,
                  )),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel'),
            ),
            Obx(() => ElevatedButton(
              onPressed: controller.isAddingCategory.value ? null : () => controller.saveCategory(id: categoryId),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
              child: controller.isAddingCategory.value 
                  ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Text('Save'),
            )),
          ],
        );
      },
    );
  }
}

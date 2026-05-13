import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_web/app/modules/services/controllers/services_controller.dart';
import 'package:admin_web/widgets/main_layout.dart';
import 'package:admin_web/widgets/data_table_widget.dart';
import 'package:admin_web/widgets/confirm_dialog_widget.dart';
import 'package:admin_web/app/utils/app_colors.dart';
import 'package:admin_web/app/models/service_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ServicesView extends GetView<ServicesController> {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Services & Pricing',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Manage Services', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                onPressed: () => _showAddEditModal(context),
                icon: const Icon(Icons.add),
                label: const Text('Add Service'),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildCategoryTabs(),
          const SizedBox(height: 16),
          Obx(() => DataTableWidget(
            isLoading: controller.isLoading.value,
            columns: const [
              DataColumn(label: Text('Service Name')),
              DataColumn(label: Text('Category')),
              DataColumn(label: Text('Base Price')),
              DataColumn(label: Text('Duration (mins)')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Actions')),
            ],
            rows: controller.filteredServices.map((s) => _buildRow(context, s)).toList(),
          )),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Obx(() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildTab('all', 'All Categories'),
            ...controller.categories.map((c) => _buildTab(c.id ?? '', c.name ?? '')),
          ],
        ),
      );
    });
  }

  Widget _buildTab(String id, String label) {
    final isSelected = controller.selectedCategoryFilter.value == id;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => controller.setFilter(id),
        selectedColor: AppColors.primaryLight,
        labelStyle: TextStyle(color: isSelected ? AppColors.primary : AppColors.textSecondary),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: AppColors.border)),
      ),
    );
  }

  DataRow _buildRow(BuildContext context, ServiceModel service) {
    return DataRow(cells: [
      DataCell(Row(
        children: [
          if ((service.iconUrl ?? '').isNotEmpty) ...[
            Image.network(service.iconUrl!, width: 24, height: 24, errorBuilder: (_,__,___) => const Icon(Icons.design_services, size: 24)),
            const SizedBox(width: 8),
          ],
          Text(service.name ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      )),
      DataCell(Text(service.categoryName ?? '')),
      DataCell(Text('₹${(service.basePrice ?? 0.0).toStringAsFixed(2)}')),
      DataCell(Text(service.duration ?? '')),
      DataCell(
        Switch(
          value: service.isActive ?? false,
          onChanged: (val) => controller.toggleActive(service.id ?? '', val),
          activeColor: AppColors.success,
        ),
      ),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: AppColors.primary),
            onPressed: () => _showAddEditModal(context, service: service),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppColors.error),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => ConfirmDialogWidget(
                  title: 'Delete Service',
                  message: 'Are you sure you want to delete ${service.name ?? ''}?',
                  confirmColor: AppColors.error,
                  onConfirm: () => controller.deleteService(service.id ?? ''),
                ),
              );
            },
          ),
        ],
      )),
    ]);
  }

  void _showAddEditModal(BuildContext context, {ServiceModel? service}) {
    final nameController = TextEditingController(text: service?.name);
    final descController = TextEditingController(text: service?.description);
    final priceController = TextEditingController(text: service?.basePrice.toString());
    final durationController = TextEditingController(text: service?.duration);
    String selectedCatId = service?.categoryId ?? (controller.categories.isNotEmpty ? controller.categories.first.id ?? '' : '');
    String selectedCatName = service?.categoryName ?? (controller.categories.isNotEmpty ? controller.categories.first.name ?? '' : '');
    bool isActive = service?.isActive ?? true;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(service == null ? 'Add Service' : 'Edit Service'),
              content: SizedBox(
                width: 500,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Service Name', border: OutlineInputBorder())),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: selectedCatId.isNotEmpty ? selectedCatId : null,
                        decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
                        items: controller.categories.map((c) => DropdownMenuItem(value: c.id ?? '', child: Text(c.name ?? ''))).toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedCatId = val!;
                            selectedCatName = controller.categories.firstWhere((c) => c.id == val).name ?? '';
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(controller: descController, decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()), maxLines: 3),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(child: TextField(controller: priceController, decoration: const InputDecoration(labelText: 'Base Price (₹)', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
                          const SizedBox(width: 16),
                          Expanded(child: TextField(controller: durationController, decoration: const InputDecoration(labelText: 'Duration (mins)', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SwitchListTile(
                        title: const Text('Active'),
                        value: isActive,
                        onChanged: (val) => setState(() => isActive = val),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
                Obx(() => ElevatedButton(
                  onPressed: controller.isSaving.value ? null : () {
                    final price = double.tryParse(priceController.text) ?? 0.0;
                    final duration = durationController.text;
                    
                    final newService = ServiceModel(
                      id: service?.id ?? const Uuid().v4(),
                      name: nameController.text,
                      categoryId: selectedCatId,
                      categoryName: selectedCatName,
                      description: descController.text,
                      priceType: 'fixed',
                      iconUrl: service?.iconUrl ?? '',
                      imageUrl: service?.imageUrl ?? '',
                      basePrice: price,
                      duration: duration,
                      sortOrder: service?.sortOrder ?? 0,
                      isActive: isActive,
                      createdAt: service?.createdAt ?? Timestamp.now(),
                      updatedAt: Timestamp.now(),
                    );
                    controller.saveService(newService);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
                  child: controller.isSaving.value ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : const Text('Save'),
                )),
              ],
            );
          },
        );
      },
    );
  }
}

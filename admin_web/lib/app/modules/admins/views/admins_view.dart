import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_web/app/modules/admins/controllers/admins_controller.dart';
import 'package:admin_web/widgets/main_layout.dart';
import 'package:admin_web/widgets/data_table_widget.dart';
import 'package:admin_web/app/utils/app_colors.dart';
import 'package:admin_web/app/models/admin_model.dart';
import 'package:intl/intl.dart';

class AdminsView extends GetView<AdminsController> {
  const AdminsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Admin Users',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Manage Team', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                onPressed: () => _showAddAdminModal(context),
                icon: const Icon(Icons.add),
                label: const Text('Add Admin'),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Obx(() => DataTableWidget(
            isLoading: controller.isLoading.value,
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Role')),
              DataColumn(label: Text('Created Date')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Actions')),
            ],
            rows: controller.allAdmins.map((a) => _buildRow(context, a)).toList(),
          )),
        ],
      ),
    );
  }

  DataRow _buildRow(BuildContext context, AdminModel admin) {
    return DataRow(cells: [
      DataCell(Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primaryLight,
            child: Text((admin.name?.isNotEmpty ?? false) ? admin.name![0].toUpperCase() : 'A', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12),
          Text(admin.name ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      )),
      DataCell(Text(admin.email ?? '')),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: AppColors.backgroundDark.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
          child: Text((admin.role ?? '').toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ),
      ),
      DataCell(Text(admin.createdAt != null ? DateFormat('dd MMM yyyy').format(admin.createdAt!.toDate()) : '')),
      DataCell(
        Switch(
          value: admin.isActive ?? false,
          onChanged: (val) => controller.toggleActive(admin.id ?? '', val),
          activeColor: AppColors.success,
        ),
      ),
      DataCell(
        IconButton(
          icon: const Icon(Icons.edit_outlined, color: AppColors.primary),
          onPressed: () => _showRoleDialog(context, admin),
        ),
      ),
    ]);
  }

  void _showAddAdminModal(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    String selectedRole = 'manager';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add New Admin'),
              content: SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Full Name', border: OutlineInputBorder())),
                    const SizedBox(height: 16),
                    TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email Address', border: OutlineInputBorder())),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedRole,
                      decoration: const InputDecoration(labelText: 'Role', border: OutlineInputBorder()),
                      items: const [
                        DropdownMenuItem(value: 'superadmin', child: Text('Super Admin')),
                        DropdownMenuItem(value: 'manager', child: Text('Manager')),
                        DropdownMenuItem(value: 'support', child: Text('Support Staff')),
                      ],
                      onChanged: (val) => setState(() => selectedRole = val!),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: AppColors.infoLight, borderRadius: BorderRadius.circular(8)),
                      child: const Row(
                        children: [
                          Icon(Icons.info, color: AppColors.info, size: 20),
                          SizedBox(width: 8),
                          Expanded(child: Text('An account will need to be created in Firebase Authentication for this email. This creates the profile document.', style: TextStyle(fontSize: 12, color: AppColors.textSecondary))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty && emailController.text.isNotEmpty) {
                      controller.saveAdmin(nameController.text, emailController.text, selectedRole);
                      Get.back();
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showRoleDialog(BuildContext context, AdminModel admin) {
    String selectedRole = admin.role ?? 'support';
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Change Admin Role'),
              content: DropdownButtonFormField<String>(
                value: selectedRole,
                decoration: const InputDecoration(labelText: 'Role', border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(value: 'superadmin', child: Text('Super Admin')),
                  DropdownMenuItem(value: 'manager', child: Text('Manager')),
                  DropdownMenuItem(value: 'support', child: Text('Support Staff')),
                ],
                onChanged: (val) => setState(() => selectedRole = val ?? 'support'),
              ),
              actions: [
                TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
                ElevatedButton(
                  onPressed: () {
                    if (admin.id != null) {
                      controller.updateRole(admin.id!, selectedRole);
                    }
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
                  child: const Text('Update'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

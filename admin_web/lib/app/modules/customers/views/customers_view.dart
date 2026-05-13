import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_web/app/modules/customers/controllers/customers_controller.dart';
import 'package:admin_web/widgets/main_layout.dart';
import 'package:admin_web/widgets/data_table_widget.dart';
import 'package:admin_web/widgets/detail_modal_widget.dart';
import 'package:admin_web/app/utils/app_colors.dart';
import 'package:admin_web/app/models/customer_model.dart';
import 'package:admin_web/widgets/safe_avatar_widget.dart';

class CustomersView extends GetView<CustomersController> {
  const CustomersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Customers',
      child: Column(
        children: [
          _buildSearchField(),
          const SizedBox(height: 20),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return DataTableWidget(
                columns: const [
                  DataColumn(label: Text('Customer')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Phone')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: controller.filteredCustomers.map((customer) {
                  return DataRow(cells: [
                    DataCell(Row(
                      children: [
                        SafeAvatar(
                          imageUrl: customer.profileImage,
                          fallbackInitial: customer.fullName?.isNotEmpty == true ? customer.fullName![0] : 'C',
                          radius: 18,
                        ),
                        const SizedBox(width: 10),
                        Text(customer.fullName ?? ''),
                      ],
                    )),
                    DataCell(Text(customer.email ?? '')),
                    DataCell(Text(customer.phoneNumber ?? '')),
                    DataCell(Text(customer.isBlocked == true ? 'Blocked' : 'Active', 
                        style: TextStyle(color: customer.isBlocked == true ? AppColors.error : AppColors.success))),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.visibility, color: AppColors.primary),
                          onPressed: () => _showDetails(context, customer),
                        ),
                        IconButton(
                          icon: Icon(customer.isBlocked == true ? Icons.lock_open : Icons.lock, 
                              color: customer.isBlocked == true ? AppColors.success : AppColors.warning),
                          onPressed: () => controller.blockCustomer(customer.id!, !(customer.isBlocked ?? false)),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: AppColors.error),
                          onPressed: () => controller.deleteCustomer(customer.id!),
                        ),
                      ],
                    )),
                  ]);
                }).toList(),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search by Name or Email...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onChanged: (value) => controller.updateSearchQuery(value),
    );
  }

  void _showDetails(BuildContext context, CustomerModel customer) {
    Get.dialog(
      DetailModalWidget(
        title: 'Customer Details',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SafeAvatar(
                imageUrl: customer.profileImage,
                fallbackInitial: customer.fullName?.isNotEmpty == true ? customer.fullName![0] : 'C',
                radius: 40,
              ),
            ),
            const SizedBox(height: 20),
            _detailRow('Full Name', customer.fullName ?? ''),
            _detailRow('Email', customer.email ?? ''),
            _detailRow('Phone', customer.phoneNumber ?? ''),
            _detailRow('Status', customer.isBlocked == true ? 'Blocked' : 'Active'),
            _detailRow('Active', customer.isActive == true ? 'Yes' : 'No'),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}

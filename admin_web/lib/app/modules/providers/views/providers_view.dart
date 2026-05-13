import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:admin_web/app/modules/providers/controllers/providers_controller.dart';
import 'package:admin_web/widgets/main_layout.dart';
import 'package:admin_web/widgets/data_table_widget.dart';
import 'package:admin_web/widgets/detail_modal_widget.dart';
import 'package:admin_web/widgets/status_chip_widget.dart';
import 'package:admin_web/app/utils/app_colors.dart';
import 'package:admin_web/app/models/provider_model.dart';
import 'package:admin_web/widgets/provider_avatar_widget.dart';

class ProvidersView extends GetView<ProvidersController> {
  const ProvidersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Providers',
      child: Column(
        children: [
          _buildFilters(),
          const SizedBox(height: 20),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return DataTableWidget(
                columns: const [
                  DataColumn(label: Text('Business')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Phone')),
                  DataColumn(label: Text('Commission')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: controller.filteredProviders.map((provider) {
                  return DataRow(cells: [
                    DataCell(Row(
                      children: [
                        ProviderAvatar(provider: provider, radius: 15),
                        const SizedBox(width: 8),
                        Text(provider.businessName),
                      ],
                    )),
                    DataCell(Text(provider.email)),
                    DataCell(Text(provider.phone)),
                    DataCell(Text('${provider.commissionRate.toStringAsFixed(1)}%')),
                    DataCell(StatusChipWidget(
                      status: provider.isActive ? 'completed' : 'cancelled',
                    )),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.visibility, color: AppColors.primary),
                          onPressed: () => _showDetails(context, provider),
                        ),
                        Switch(
                          value: provider.isActive,
                          onChanged: (value) => controller.toggleActive(provider.id, value),
                          activeColor: AppColors.success,
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

  Widget _buildFilters() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search by Business name...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onChanged: (value) => controller.updateSearchQuery(value),
          ),
        ),
        const SizedBox(width: 20),
        Obx(() => DropdownButton<String>(
          value: controller.statusFilter.value,
          items: ['All', 'Active', 'Inactive']
              .map((s) => DropdownMenuItem(value: s, child: Text(s)))
              .toList(),
          onChanged: (value) => controller.updateStatusFilter(value!),
        )),
      ],
    );
  }

  void _showDetails(BuildContext context, ProviderModel provider) {
    final commissionController = TextEditingController(text: provider.commissionRate.toString());
    
    Get.dialog(
      DetailModalWidget(
        title: 'Provider Details',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ProviderAvatar(provider: provider, radius: 50),
              ),
            ),
            _detailRow('Business Name', provider.businessName),
            _detailRow('Email', provider.email),
            _detailRow('Phone', provider.phone),
            _detailRow('Description', provider.description.isEmpty ? 'No description' : provider.description),
            _detailRow('Status', provider.isActive ? 'Active' : 'Inactive'),
            _detailRow('Jobs Completed', provider.totalBookings.toString()),
            _detailRow('Total Reviews', provider.totalRatings.toString()),
            _detailRow('Rating', provider.rating.toStringAsFixed(1)),
            _detailRow('Service Area', provider.serviceArea.isEmpty ? 'Not specified' : provider.serviceArea),
            const SizedBox(height: 10),
            const Text('Categories:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: provider.categories.map((catId) => Chip(
                label: Text(catId, style: const TextStyle(fontSize: 12)),
                backgroundColor: AppColors.primary.withOpacity(0.1),
              )).toList(),
            ),
            const SizedBox(height: 20),
            _linkRow('Business License', provider.businessLicenseUrl),
            _linkRow('ID Proof', provider.idProofUrl),
            const SizedBox(height: 20),
            const Text('Commission Rate (%)', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: commissionController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(suffixText: '%'),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              double? rate = double.tryParse(commissionController.text);
              if (rate != null) {
                controller.updateCommission(provider.id, rate);
                Get.back();
              }
            },
            child: const Text('Update Commission'),
          ),
        ],
      ),
    );
  }

  Widget _linkRow(String label, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          if (url.isNotEmpty)
            TextButton(
              onPressed: () async {
                final uri = Uri.parse(url);
                try {
                  await launchUrl(uri);
                } catch (e) {
                  Get.snackbar('Error', 'Could not launch URL');
                }
              },
              child: const Text('View Document', style: TextStyle(color: AppColors.primary)),
            )
          else
            const Text('Not provided'),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

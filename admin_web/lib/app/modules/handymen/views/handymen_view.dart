import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_web/app/modules/handymen/controllers/handymen_controller.dart';
import 'package:admin_web/widgets/main_layout.dart';
import 'package:admin_web/widgets/data_table_widget.dart';
import 'package:admin_web/widgets/detail_modal_widget.dart';
import 'package:admin_web/app/utils/app_colors.dart';
import 'package:admin_web/app/models/handyman_model.dart';
import 'package:admin_web/widgets/safe_avatar_widget.dart';

class HandymenView extends GetView<HandymenController> {
  const HandymenView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Handymen',
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            _buildFilterRow(),
            const SizedBox(height: 16),
            const TabBar(
              tabs: [
                Tab(text: 'Pending'),
                Tab(text: 'Approved'),
                Tab(text: 'Rejected'),
              ],
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.primary,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: TabBarView(
                children: [
                  Obx(() => _buildTable(context, controller.pendingHandymen, true)),
                  Obx(() => _buildTable(context, controller.approvedHandymen, false)),
                  Obx(() => _buildTable(context, controller.rejectedHandymen, false, isRejected: true)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterRow() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search by name or phone...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onChanged: controller.updateSearchQuery,
          ),
        ),
      ],
    );
  }

  Widget _buildTable(BuildContext context, List<HandymanModel> list, bool isPending, {bool isRejected = false}) {
    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }
    return DataTableWidget(
      isLoading: false,
      columns: [
        const DataColumn(label: Text('Handyman')),
        const DataColumn(label: Text('Phone')),
        if (!isPending && !isRejected) const DataColumn(label: Text('Commission %')),
        const DataColumn(label: Text('Rating')),
        const DataColumn(label: Text('Jobs')),
        const DataColumn(label: Text('Status')),
        const DataColumn(label: Text('Actions')),
      ],
      rows: list.map((h) => _buildRow(context, h, isPending, isRejected)).toList(),
    );
  }

  DataRow _buildRow(BuildContext context, HandymanModel handyman, bool isPending, bool isRejected) {
    return DataRow(cells: [
      DataCell(Row(
        children: [
          SafeAvatar(
            imageUrl: handyman.photoUrl,
            fallbackInitial: handyman.fullName?.isNotEmpty == true ? handyman.fullName![0] : 'H',
            radius: 20,
            fallbackIcon: Icons.person,
          ),
          const SizedBox(width: 12),
          Text(handyman.fullName ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      )),
      DataCell(Text(handyman.phone ?? '')),
      if (!isPending && !isRejected)
        DataCell(
          Row(
            children: [
              Text('${handyman.commissionRate ?? 0}%'),
              IconButton(
                icon: const Icon(Icons.edit, size: 16),
                onPressed: () => _showCommissionDialog(context, handyman),
              ),
            ],
          ),
        ),
      DataCell(Row(
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 16),
          const SizedBox(width: 4),
          Text((handyman.rating ?? 0.0).toStringAsFixed(1)),
        ],
      )),
      DataCell(Text((handyman.totalJobs ?? 0).toString())),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getStatusColor(handyman, isPending, isRejected).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            _getStatusText(handyman, isPending, isRejected),
            style: TextStyle(
              color: _getStatusColor(handyman, isPending, isRejected),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      DataCell(Row(
        children: [
          if (isPending) ...[
            IconButton(
              icon: const Icon(Icons.check_circle_outline, color: Colors.green),
              onPressed: () => controller.approveHandyman(handyman.id!),
              tooltip: 'Approve',
            ),
            IconButton(
              icon: const Icon(Icons.cancel_outlined, color: Colors.red),
              onPressed: () => _showRejectDialog(context, handyman),
              tooltip: 'Reject',
            ),
          ],
          IconButton(
            icon: const Icon(Icons.visibility_outlined, color: AppColors.primary),
            onPressed: () => _showDetails(context, handyman, isPending, isRejected),
          ),
          if (!isPending && !isRejected)
            Switch(
              value: handyman.isActive ?? false,
              activeColor: AppColors.success,
              onChanged: (val) => controller.toggleActive(handyman.id!, val),
            ),
        ],
      )),
    ]);
  }

  Color _getStatusColor(HandymanModel h, bool isPending, bool isRejected) {
    if (isPending) return Colors.orange;
    if (isRejected) return Colors.red;
    return (h.isActive ?? false) ? AppColors.success : AppColors.error;
  }

  String _getStatusText(HandymanModel h, bool isPending, bool isRejected) {
    if (isPending) return 'PENDING';
    if (isRejected) return 'REJECTED';
    return (h.isActive ?? false) ? 'ACTIVE' : 'INACTIVE';
  }

  void _showCommissionDialog(BuildContext context, HandymanModel handyman) {
    final controller = TextEditingController(text: (handyman.commissionRate ?? 0).toString());
    Get.dialog(
      AlertDialog(
        title: const Text('Update Commission Rate'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(suffixText: '%', labelText: 'Commission Rate'),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              this.controller.updateCommission(handyman.id!, int.tryParse(controller.text) ?? 0);
              Get.back();
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showRejectDialog(BuildContext context, HandymanModel handyman) {
    final reasonController = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: const Text('Reject Application'),
        content: TextField(
          controller: reasonController,
          decoration: const InputDecoration(hintText: 'Enter rejection reason'),
          maxLines: 3,
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              controller.rejectHandyman(handyman.id!, reasonController.text);
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text('Reject'),
          ),
        ],
      ),
    );
  }

  void _showDetails(BuildContext context, HandymanModel handyman, bool isPending, bool isRejected) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.centerRight,
          child: DetailModalWidget(
            title: 'Handyman Details',
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
              if (isPending) ...[
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    controller.approveHandyman(handyman.id!);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                  child: const Text('Approve'),
                ),
              ],
            ],
            child: Material(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SafeAvatar(
                        imageUrl: handyman.photoUrl,
                        fallbackInitial: handyman.fullName?.isNotEmpty == true ? handyman.fullName![0] : 'H',
                        radius: 40,
                        fallbackIcon: Icons.person,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(child: Text(handyman.fullName ?? '', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                    const SizedBox(height: 24),
                    const Text('Contact Information', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
                    const Divider(),
                    _detailRow('Phone', handyman.phone),
                    _detailRow('Email', handyman.email),
                    const SizedBox(height: 24),
                    const Text('Onboarding Information', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
                    const Divider(),
                    _detailRow('Status', handyman.onboardingStatus?.toUpperCase() ?? 'N/A'),
                    _detailRow('Service Area', handyman.serviceArea),
                    _detailRow('Skills', handyman.skills?.join(', ')),
                    if (handyman.idProofUrl != null) ...[
                      const SizedBox(height: 12),
                      const Text('ID Proof', style: TextStyle(color: AppColors.textSecondary)),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () => _showImageDialog(context, handyman.idProofUrl!),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(handyman.idProofUrl!, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ],
                    if (isRejected && handyman.rejectionReason != null) ...[
                      const SizedBox(height: 24),
                      const Text('Rejection Info', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                      const Divider(),
                      _detailRow('Reason', handyman.rejectionReason),
                    ],
                    const SizedBox(height: 24),
                    const Text('Statistics', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
                    const Divider(),
                    _detailRow('Rating', '${handyman.rating ?? 0.0} (${handyman.totalRatings ?? 0} reviews)'),
                    _detailRow('Total Jobs', (handyman.totalJobs ?? 0).toString()),
                    _detailRow('Total Earnings', '₹${(handyman.totalEarnings ?? 0.0).toStringAsFixed(2)}'),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }

  void _showImageDialog(BuildContext context, String imageUrl) {
    Get.dialog(
      Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Image.network(imageUrl),
                Positioned(
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, shadows: [Shadow(blurRadius: 2)]),
                    onPressed: () => Get.back(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 120, child: Text(label, style: const TextStyle(color: AppColors.textSecondary))),
          Expanded(child: Text(value ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}

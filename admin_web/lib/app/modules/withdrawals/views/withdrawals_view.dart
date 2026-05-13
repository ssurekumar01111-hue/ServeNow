import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_web/app/modules/withdrawals/controllers/withdrawals_controller.dart';
import 'package:admin_web/widgets/main_layout.dart';
import 'package:admin_web/widgets/data_table_widget.dart';
import 'package:admin_web/widgets/stat_card_widget.dart';
import 'package:admin_web/widgets/status_chip_widget.dart';
import 'package:admin_web/widgets/confirm_dialog_widget.dart';
import 'package:admin_web/app/utils/app_colors.dart';
import 'package:admin_web/app/models/transaction_model.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WithdrawalsView extends GetView<WithdrawalsController> {
  const WithdrawalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Withdrawal Requests',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatsRow(),
          const SizedBox(height: 24),
          _buildFilterTabs(),
          const SizedBox(height: 16),
          Obx(() => DataTableWidget(
            isLoading: controller.isLoading.value,
            columns: const [
              DataColumn(label: Text('Transaction ID')),
              DataColumn(label: Text('User Details')),
              DataColumn(label: Text('Amount')),
              DataColumn(label: Text('Requested Date')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Actions')),
            ],
            rows: controller.filteredWithdrawals.map((w) => _buildRow(context, w)).toList(),
          )),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Obx(() => GridView.count(
      crossAxisCount: 4,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.2,
      children: [
        StatCard(
          title: 'Pending Requests',
          value: controller.pendingCount.value.toString(),
          icon: Icons.pending_actions,
          color1: AppColors.statOrange1,
          color2: AppColors.statOrange2,
        ),
        StatCard(
          title: 'Pending Amount',
          value: '₹${controller.pendingAmount.value.toStringAsFixed(2)}',
          icon: Icons.currency_rupee,
          color1: AppColors.statBlue1,
          color2: AppColors.statBlue2,
        ),
        StatCard(
          title: 'Approved Requests',
          value: controller.completedCount.value.toString(),
          icon: Icons.check_circle_outline,
          color1: AppColors.statGreen1,
          color2: AppColors.statGreen2,
        ),
        StatCard(
          title: 'Total Payouts',
          value: '₹${controller.completedAmount.value.toStringAsFixed(2)}',
          icon: Icons.account_balance_wallet,
          color1: AppColors.statPurple1,
          color2: AppColors.statPurple2,
        ),
      ],
    ));
  }

  Widget _buildFilterTabs() {
    return Obx(() => Row(
      children: [
        _buildTab('pending', 'Pending'),
        const SizedBox(width: 8),
        _buildTab('approved', 'Approved'),
        const SizedBox(width: 8),
        _buildTab('rejected', 'Rejected'),
      ],
    ));
  }

  Widget _buildTab(String status, String label) {
    final isSelected = controller.statusFilter.value == status;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => controller.setFilter(status),
      selectedColor: AppColors.primaryLight,
      labelStyle: TextStyle(color: isSelected ? AppColors.primary : AppColors.textSecondary),
    );
  }

  DataRow _buildRow(BuildContext context, TransactionModel t) {
    return DataRow(cells: [
      DataCell(Text('#${(t.id ?? '').substring(0, (t.id?.length ?? 0) > 8 ? 8 : (t.id?.length ?? 0))}', style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold))),
      DataCell(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: AppColors.backgroundDark.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
            child: Text((t.userType ?? '').toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 2),
          const Text('Bank Details on File', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        ],
      )),
      DataCell(Text('₹${(t.amount ?? 0).toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.success))),
      DataCell(Text(DateFormat('dd MMM yyyy, HH:mm').format((t.createdAt ?? Timestamp.now()).toDate()))),
      DataCell(StatusChipWidget(status: t.status ?? '')),
      DataCell(
        t.status == 'pending'
            ? Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _showApproveDialog(context, t),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.success, foregroundColor: Colors.white, minimumSize: const Size(0, 32), padding: const EdgeInsets.symmetric(horizontal: 12)),
                    child: const Text('Approve'),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () => _showRejectDialog(context, t),
                    style: OutlinedButton.styleFrom(foregroundColor: AppColors.error, side: const BorderSide(color: AppColors.error), minimumSize: const Size(0, 32), padding: const EdgeInsets.symmetric(horizontal: 12)),
                    child: const Text('Reject'),
                  ),
                ],
              )
            : const Text('--'),
      ),
    ]);
  }

  void _showApproveDialog(BuildContext context, TransactionModel t) {
    final noteController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => ConfirmDialogWidget(
        title: 'Approve Withdrawal',
        message: 'Mark ₹${t.amount ?? 0} as paid?',
        confirmColor: AppColors.success,
        confirmText: 'Approve & Mark Paid',
        extraContent: TextField(controller: noteController, decoration: const InputDecoration(labelText: 'Transaction Reference (Optional)', border: OutlineInputBorder())),
        onConfirm: () => controller.approveWithdrawal(t.id!, noteController.text),
      ),
    );
  }

  void _showRejectDialog(BuildContext context, TransactionModel t) {
    final reasonController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => ConfirmDialogWidget(
        title: 'Reject Withdrawal',
        message: 'Are you sure you want to reject this request?',
        confirmColor: AppColors.error,
        confirmText: 'Reject',
        extraContent: TextField(controller: reasonController, decoration: const InputDecoration(labelText: 'Reason for rejection', border: OutlineInputBorder())),
        onConfirm: () {
          if (reasonController.text.isNotEmpty) {
            controller.rejectWithdrawal(t.id!, reasonController.text);
          } else {
            Get.snackbar('Error', 'Rejection reason is required');
          }
        },
      ),
    );
  }
}

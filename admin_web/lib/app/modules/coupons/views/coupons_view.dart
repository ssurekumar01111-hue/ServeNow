import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_web/app/modules/coupons/controllers/coupons_controller.dart';
import 'package:admin_web/widgets/main_layout.dart';
import 'package:admin_web/widgets/data_table_widget.dart';
import 'package:admin_web/widgets/confirm_dialog_widget.dart';
import 'package:admin_web/app/utils/app_colors.dart';
import 'package:admin_web/app/models/coupon_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class CouponsView extends GetView<CouponsController> {
  const CouponsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Coupons & Discounts',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Manage Coupons', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                onPressed: () => _showAddEditModal(context),
                icon: const Icon(Icons.add),
                label: const Text('Create Coupon'),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Obx(() => DataTableWidget(
            isLoading: controller.isLoading.value,
            columns: const [
              DataColumn(label: Text('Code')),
              DataColumn(label: Text('Type & Value')),
              DataColumn(label: Text('Usage')),
              DataColumn(label: Text('Valid Until')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Actions')),
            ],
            rows: controller.allCoupons.map((c) => _buildRow(context, c)).toList(),
          )),
        ],
      ),
    );
  }

  DataRow _buildRow(BuildContext context, CouponModel coupon) {
    final bool isExpired = coupon.validUntil != null ? coupon.validUntil!.toDate().isBefore(DateTime.now()) : false;

    return DataRow(cells: [
      DataCell(Text(coupon.code ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', letterSpacing: 1.5))),
      DataCell(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(4)),
            child: Text((coupon.discountType ?? '').toUpperCase(), style: const TextStyle(fontSize: 10, color: AppColors.primary, fontWeight: FontWeight.bold)),
          ),
          Text(coupon.discountType == 'percent' ? '${coupon.discountValue ?? 0}%' : '₹${coupon.discountValue ?? 0}'),
        ],
      )),
      DataCell(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${coupon.usedCount ?? 0} / ${coupon.usageLimit ?? 0}'),
          SizedBox(
            width: 100,
            child: LinearProgressIndicator(
              value: (coupon.usageLimit ?? 0) > 0 ? ((coupon.usedCount ?? 0) / coupon.usageLimit!) : 0,
              backgroundColor: AppColors.border,
              valueColor: AlwaysStoppedAnimation<Color>((coupon.usedCount ?? 0) >= (coupon.usageLimit ?? 0) ? AppColors.error : AppColors.success),
            ),
          )
        ],
      )),
      DataCell(Text(coupon.validUntil != null ? DateFormat('dd MMM yyyy').format(coupon.validUntil!.toDate()) : '', style: TextStyle(color: isExpired ? AppColors.error : AppColors.textPrimary))),
      DataCell(
        Switch(
          value: coupon.isActive ?? false,
          onChanged: (val) => controller.toggleActive(coupon.id ?? '', val),
          activeColor: AppColors.success,
        ),
      ),
      DataCell(Row(
        children: [
          IconButton(icon: const Icon(Icons.edit_outlined, color: AppColors.primary), onPressed: () => _showAddEditModal(context, coupon: coupon)),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppColors.error),
            onPressed: () {
              if (coupon.id != null) {
                showDialog(
                  context: context,
                  builder: (context) => ConfirmDialogWidget(
                    title: 'Delete Coupon',
                    message: 'Are you sure you want to delete ${coupon.code ?? ''}?',
                    confirmColor: AppColors.error,
                    onConfirm: () => controller.deleteCoupon(coupon.id!),
                  ),
                );
              }
            },
          ),
        ],
      )),
    ]);
  }

  void _showAddEditModal(BuildContext context, {CouponModel? coupon}) {
    final codeController = TextEditingController(text: coupon?.code);
    final valueController = TextEditingController(text: coupon?.discountValue?.toString() ?? '0');
    final limitController = TextEditingController(text: coupon?.usageLimit?.toString() ?? '100');
    final minOrderController = TextEditingController(text: coupon?.minOrderAmount?.toString() ?? '0');
    final maxDiscController = TextEditingController(text: coupon?.maxDiscount?.toString() ?? '0');
    
    String type = coupon?.discountType ?? 'percent';
    DateTime validFrom = coupon?.validFrom?.toDate() ?? DateTime.now();
    DateTime validUntil = coupon?.validUntil?.toDate() ?? DateTime.now().add(const Duration(days: 30));
    bool isActive = coupon?.isActive ?? true;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(coupon == null ? 'Create Coupon' : 'Edit Coupon'),
              content: SizedBox(
                width: 400,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(controller: codeController, decoration: const InputDecoration(labelText: 'Coupon Code (e.g. SUMMER50)', border: OutlineInputBorder())),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: type,
                              decoration: const InputDecoration(labelText: 'Discount Type', border: OutlineInputBorder()),
                              items: const [
                                DropdownMenuItem(value: 'percent', child: Text('Percentage (%)')),
                                DropdownMenuItem(value: 'flat', child: Text('Flat Amount (₹)')),
                              ],
                              onChanged: (val) => setState(() => type = val!),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(child: TextField(controller: valueController, decoration: const InputDecoration(labelText: 'Value', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(child: TextField(controller: minOrderController, decoration: const InputDecoration(labelText: 'Min Order (₹)', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
                          const SizedBox(width: 16),
                          Expanded(child: TextField(controller: maxDiscController, decoration: InputDecoration(labelText: 'Max Disc. (₹)', border: const OutlineInputBorder(), enabled: type == 'percent'), keyboardType: TextInputType.number, enabled: type == 'percent')),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextField(controller: limitController, decoration: const InputDecoration(labelText: 'Total Usage Limit', border: OutlineInputBorder()), keyboardType: TextInputType.number),
                      const SizedBox(height: 16),
                      SwitchListTile(title: const Text('Active'), value: isActive, onChanged: (val) => setState(() => isActive = val)),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
                ElevatedButton(
                  onPressed: () {
                    final newCoupon = CouponModel(
                      id: coupon?.id ?? const Uuid().v4(),
                      code: codeController.text.toUpperCase(),
                      discountType: type,
                      discountValue: double.tryParse(valueController.text) ?? 0,
                      minOrderAmount: double.tryParse(minOrderController.text) ?? 0,
                      maxDiscount: double.tryParse(maxDiscController.text) ?? 0,
                      usageLimit: int.tryParse(limitController.text) ?? 0,
                      usedCount: coupon?.usedCount ?? 0,
                      isActive: isActive,
                      applicableCategories: coupon?.applicableCategories ?? [],
                      validFrom: Timestamp.fromDate(validFrom),
                      validUntil: Timestamp.fromDate(validUntil),
                      createdAt: coupon?.createdAt ?? Timestamp.now(),
                    );
                    controller.saveCoupon(newCoupon);
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
                  child: const Text('Save Coupon'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

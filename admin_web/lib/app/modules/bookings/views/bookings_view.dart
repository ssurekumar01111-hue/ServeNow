import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_web/app/modules/bookings/controllers/bookings_controller.dart';
import 'package:admin_web/widgets/main_layout.dart';
import 'package:admin_web/widgets/data_table_widget.dart';
import 'package:admin_web/widgets/status_chip_widget.dart';
import 'package:admin_web/widgets/detail_modal_widget.dart';
import 'package:admin_web/app/utils/app_colors.dart';
import 'package:admin_web/app/models/booking_model.dart';
import 'package:intl/intl.dart';

class BookingsView extends GetView<BookingsController> {
  const BookingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Bookings',
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
                  DataColumn(label: Text('Booking ID')),
                  DataColumn(label: Text('Customer')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Amount')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: controller.filteredBookings.map((booking) {
                  return DataRow(cells: [
                    DataCell(Text(booking.id ?? '')),
                    DataCell(Text(booking.customerId ?? '')),
                    DataCell(Text(booking.createdAt != null 
                        ? DateFormat('dd MMM yyyy, hh:mm a').format(booking.createdAt!) 
                        : '')),
                    DataCell(Text('\$${booking.amount?.toStringAsFixed(2) ?? '0.00'}')),
                    DataCell(StatusChipWidget(status: booking.status ?? 'pending')),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.visibility, color: AppColors.primary),
                          onPressed: () => _showDetails(context, booking),
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
              hintText: 'Search by Booking ID or Customer ID...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onChanged: (value) => controller.updateSearchQuery(value),
          ),
        ),
        const SizedBox(width: 20),
        Obx(() => DropdownButton<String>(
          value: controller.statusFilter.value,
          items: ['All', 'pending', 'confirmed', 'assigned', 'enRoute', 'arrived', 'inProgress', 'completed', 'cancelled']
              .map((s) => DropdownMenuItem(value: s, child: Text(s)))
              .toList(),
          onChanged: (value) => controller.updateStatusFilter(value!),
        )),
      ],
    );
  }

  void _showDetails(BuildContext context, BookingModel booking) {
    String? selectedStatus = booking.status;
    final noteController = TextEditingController();

    Get.dialog(
      DetailModalWidget(
        title: 'Booking Details',
        child: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _detailRow('Booking ID', booking.id ?? ''),
                _detailRow('Customer ID', booking.customerId ?? ''),
                _detailRow('Provider ID', booking.providerId ?? ''),
                _detailRow('Service ID', booking.serviceId ?? ''),
                _detailRow('Address', booking.address ?? ''),
                _detailRow('Amount', '\$${booking.amount?.toStringAsFixed(2)}'),
                _detailRow('Payment', booking.paymentMethod ?? ''),
                _detailRow('Status', booking.status ?? ''),
                const Divider(height: 32),
                const Text('Admin Actions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedStatus,
                  decoration: const InputDecoration(labelText: 'Change Status', border: OutlineInputBorder()),
                  items: ['pending', 'confirmed', 'assigned', 'enRoute', 'arrived', 'inProgress', 'completed', 'cancelled']
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: noteController,
                  decoration: const InputDecoration(labelText: 'Admin Note', border: OutlineInputBorder()),
                  maxLines: 2,
                ),
              ],
            );
          }
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Close')),
          ElevatedButton(
            onPressed: () {
              if (selectedStatus != null && booking.id != null) {
                controller.updateBookingStatus(booking.id!, selectedStatus!, noteController.text);
                Get.back();
              } else {
                Get.snackbar('Error', 'Missing booking ID or status');
              }
            },
            child: const Text('Apply Status & Note'),
          ),
          if (booking.status != 'cancelled')
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
              onPressed: () {
                if (booking.id != null) {
                  controller.cancelBooking(booking.id!, 'Cancelled by Admin');
                  Get.back();
                }
              },
              child: const Text('Cancel Booking'),
            ),
          if (booking.status != 'completed' && booking.status != 'cancelled')
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.warning),
              onPressed: () {
                // controller.showReassignProvider(booking);
                Get.back();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reassign Provider feature coming soon')));
              },
              child: const Text('Reassign Provider'),
            ),
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
          Text(value),
        ],
      ),
    );
  }
}

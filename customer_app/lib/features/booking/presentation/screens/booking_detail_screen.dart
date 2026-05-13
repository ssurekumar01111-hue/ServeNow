import 'package:customer/core/constants/booking_status.dart';
import 'package:customer/core/router/app_routes.dart';
import 'package:customer/features/booking/domain/entities/booking_entity.dart';
import 'package:customer/features/booking/presentation/providers/booking_providers.dart';
import 'package:customer/features/reviews/presentation/review_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BookingDetailScreen extends ConsumerWidget {
  const BookingDetailScreen({required this.bookingId, super.key});
  final String bookingId;

  void _showCancelDialog(BuildContext context, WidgetRef ref, String id) {
    final reasonController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Booking'),
        content: TextField(
          controller: reasonController,
          decoration: const InputDecoration(hintText: 'Reason for cancellation'),
        ),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('Back')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            onPressed: () async {
              if (reasonController.text.trim().isEmpty) return;
              await ref.read(bookingRepositoryProvider).updateBookingStatus(id, BookingStatuses.cancelled);
              await ref.read(bookingRemoteDataSourceProvider).updateBookingStatusWithReason(id, BookingStatuses.cancelled, reasonController.text.trim(), 'customer');
              if (context.mounted) {
                context.pop();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Booking cancelled')));
              }
            },
            child: const Text('Confirm Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingAsync = ref.watch(bookingDetailProvider(bookingId));
    final hasReviewedAsync = ref.watch(hasReviewedProvider(bookingId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
        actions: [
          if (bookingAsync.hasValue && 
              bookingAsync.value!.status != BookingStatuses.pending && 
              bookingAsync.value!.status != BookingStatuses.confirmed && 
              bookingAsync.value!.status != BookingStatuses.cancelled)
            IconButton(
              icon: const Icon(Icons.chat_outlined),
              onPressed: () => context.push('/chat/${bookingAsync.value!.id}'),
            ),
        ],
      ),
      body: bookingAsync.when(
        data: (item) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _StatusTimeline(status: item.status),
              const Divider(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.serviceName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        Text('ID: ${item.id}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getStatusColor(item.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      item.status.toUpperCase().replaceAll('_', ' '),
                      style: TextStyle(color: _getStatusColor(item.status), fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _DetailRow(label: 'Date & Time', value: '${item.scheduledDate.toString().split(' ')[0]} at ${item.scheduledTime}'),
              _DetailRow(label: 'Address', value: item.customerAddress),
              _DetailRow(label: 'Provider', value: item.providerName),
              if (item.assignedHandymanName != null)
                _DetailRow(label: 'Handyman', value: item.assignedHandymanName!),
              _DetailRow(label: 'Amount', value: '₹${item.amount}'),
              _DetailRow(label: 'Payment', value: '${item.paymentMethod.name.toUpperCase()} (${item.paymentStatus.name})'),
              
              // Payment Badge
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: item.paymentMethod == PaymentMethod.online ? Colors.green.shade50 : Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: item.paymentMethod == PaymentMethod.online ? Colors.green.shade200 : Colors.orange.shade200),
                    ),
                    child: Text(
                      item.paymentMethod == PaymentMethod.online ? 'PAID ONLINE' : 'CASH ON DELIVERY',
                      style: TextStyle(
                        fontSize: 11, 
                        fontWeight: FontWeight.bold, 
                        color: item.paymentMethod == PaymentMethod.online ? Colors.green.shade700 : Colors.orange.shade700
                      ),
                    ),
                  ),
                ],
              ),

              if (item.paymentMethod == PaymentMethod.cod && item.status == BookingStatuses.inProgress)
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.orange.shade200)),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, color: Colors.orange),
                      const SizedBox(width: 12),
                      Expanded(child: Text('Please pay ₹${item.amount} to the handyman after the service is completed.', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500))),
                    ],
                  ),
                ),
              if (item.notes != null && item.notes!.isNotEmpty)
                _DetailRow(label: 'My Notes', value: item.notes!),
              
              const SizedBox(height: 24),
              
              // OTP Section - Only show when assigned or beyond
              if (item.status != BookingStatuses.pending && item.status != BookingStatuses.confirmed && item.status != BookingStatuses.cancelled && item.status != BookingStatuses.completed)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Column(
                    children: [
                      const Text('Share this OTP with the handyman to start the job',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.blue, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 12),
                      Text(item.otp,
                          style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 8,
                              color: Colors.blue)),
                    ],
                  ),
                ),

              if (item.status == BookingStatuses.cancelled && item.cancellationReason != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)),
                  child: Text('Cancelled by ${item.cancelledBy}: ${item.cancellationReason}', 
                    style: TextStyle(color: Colors.red.shade700, fontSize: 13)),
                ),

              const SizedBox(height: 32),
              
              // Track Handyman Button
              if (item.status == BookingStatuses.enRoute || item.status == BookingStatuses.arrived)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => context.push(AppRoutes.liveTrackingPath(item.id)),
                    icon: const Icon(Icons.location_on),
                    label: const Text('Track Handyman', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),

              // Rate Now Button
              if (item.status == BookingStatuses.completed)
                hasReviewedAsync.when(
                  data: (hasReviewed) => !hasReviewed
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              foregroundColor: Colors.black,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () => context.push(AppRoutes.rateReviewPath(item.id, item.providerId)),
                            child: const Text('Rate Now', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        )
                      : const SizedBox.shrink(),
                  loading: () => const SizedBox.shrink(),
                  error: (e, st) => const SizedBox.shrink(),
                ),

              if (item.status == BookingStatuses.pending || item.status == BookingStatuses.confirmed)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, 
                    foregroundColor: Colors.red, 
                    minimumSize: const Size(double.infinity, 50),
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => _showCancelDialog(context, ref, item.id),
                  child: const Text('Cancel Booking', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case BookingStatuses.pending: return Colors.orange;
      case BookingStatuses.confirmed: return Colors.blue;
      case BookingStatuses.assigned: return Colors.indigo;
      case BookingStatuses.enRoute: return Colors.purple;
      case BookingStatuses.arrived: return Colors.teal;
      case BookingStatuses.inProgress: return Colors.green;
      case BookingStatuses.completed: return Colors.green;
      case BookingStatuses.cancelled: return Colors.red;
      default: return Colors.grey;
    }
  }
}

class _StatusTimeline extends StatelessWidget {
  const _StatusTimeline({required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    final statusList = [
      BookingStatuses.pending,
      BookingStatuses.confirmed,
      BookingStatuses.assigned,
      BookingStatuses.enRoute,
      BookingStatuses.arrived,
      BookingStatuses.inProgress,
      BookingStatuses.completed,
    ];

    if (status == BookingStatuses.cancelled) {
      return Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(20)),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.cancel_rounded, color: Colors.red),
              SizedBox(width: 8),
              Text('Booking Cancelled', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      );
    }

    int currentIndex = statusList.indexOf(status);
    if (currentIndex == -1) currentIndex = 0;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(statusList.length, (index) {
          final isCompleted = index <= currentIndex;
          final label = _getStatusLabel(statusList[index]);
          
          return Row(
            children: [
              _buildStep(isCompleted, label, index == currentIndex),
              if (index < statusList.length - 1)
                _buildConnector(index < currentIndex),
            ],
          );
        }),
      ),
    );
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case BookingStatuses.pending: return 'Pending';
      case BookingStatuses.confirmed: return 'Confirmed';
      case BookingStatuses.assigned: return 'Assigned';
      case BookingStatuses.enRoute: return 'En Route';
      case BookingStatuses.arrived: return 'Arrived';
      case BookingStatuses.inProgress: return 'Started';
      case BookingStatuses.completed: return 'Done';
      default: return '';
    }
  }

  Widget _buildStep(bool active, String label, bool isCurrent) {
    return Column(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? Colors.blue : Colors.grey.shade300,
            border: isCurrent ? Border.all(color: Colors.blue.shade800, width: 2) : null,
          ),
          child: Icon(active ? Icons.check : Icons.circle, size: 14, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 10, color: active ? Colors.blue : Colors.grey, fontWeight: active ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }

  Widget _buildConnector(bool active) {
    return Container(width: 30, height: 2, color: active ? Colors.blue : Colors.grey.shade300);
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 100, child: Text(label, style: const TextStyle(color: Colors.grey))),
          Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}

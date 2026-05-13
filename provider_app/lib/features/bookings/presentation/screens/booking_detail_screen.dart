import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/core/widgets/shimmer_loader.dart';
import 'package:provider/features/bookings/presentation/providers/bookings_providers.dart';
import 'package:provider/features/bookings/domain/entities/booking_entity.dart';

import 'package:provider/features/auth/presentation/providers/auth_provider.dart';

class BookingDetailScreen extends ConsumerWidget {
  const BookingDetailScreen({required this.bookingId, super.key});
  final String bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingAsync = ref.watch(bookingDetailProvider(bookingId));
    final user = ref.watch(authNotifierProvider).value;

    return bookingAsync.when(
      data: (booking) {
        if (booking == null) return const Scaffold(body: Center(child: Text('Booking not found')));

        final isUnassigned = booking.providerId.isEmpty;

        return Scaffold(
          appBar: AppBar(title: const Text('Booking Details')),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isUnassigned)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.amber.shade300),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.amber),
                        SizedBox(width: 8),
                        Expanded(child: Text('This is an open job. Claim it to add it to your bookings.', style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                Text(booking.serviceName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('ID: ${booking.id}', style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6))),
                const Divider(height: 32),
                _DetailItem(context, 'Customer', booking.customerName),
                _DetailItem(context, 'Date', booking.scheduledDate.toString().split(' ')[0]),
                _DetailItem(context, 'Time', booking.scheduledTime),
                _DetailItem(context, 'Address', booking.customerAddress),
                _DetailItem(context, 'Amount', '₹${booking.amount}'),
                _DetailItem(context, 'Payment', booking.paymentStatus.name.toUpperCase()),
                const Divider(height: 32),
                
                // Handyman Assignment Status
                if (booking.assignedHandymanId != null)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.person, size: 20),
                            const SizedBox(width: 8),
                            Text('Handyman', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                booking.autoAssigned ? 'Auto-assigned' : 'Manually assigned',
                                style: const TextStyle(color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                              child: Text(booking.assignedHandymanName?[0].toUpperCase() ?? 'H'),
                            ),
                            const SizedBox(width: 12),
                            Text(booking.assignedHandymanName ?? 'Handyman', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ],
                    ),
                  )
                else if (booking.status == BookingStatus.confirmed)
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.orange),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Finding Handyman', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                                  Text('A professional will be automatically assigned within 3 minutes.', 
                                    style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                else if (!isUnassigned)
                   _DetailItem(context, 'Handyman', 'Not yet confirmed'),
                
                const SizedBox(height: 24),
                if (isUnassigned)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (user != null) {
                          try {
                            await ref.read(bookingStatusProvider.notifier).claimBooking(booking.id, user.uid, user.name ?? 'Provider');
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Job claimed successfully!')));
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to claim job: $e')));
                            }
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('CLAIM THIS JOB', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => context.push('/chat/${booking.id}'),
                          icon: const Icon(Icons.chat),
                          label: const Text('Chat with Customer'),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
      loading: () => const Scaffold(body: ShimmerLoader()),
      error: (e, st) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }

  Widget _DetailItem(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Flexible(
            child: SizedBox(
              width: 100,
              child: Text(
                label,
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

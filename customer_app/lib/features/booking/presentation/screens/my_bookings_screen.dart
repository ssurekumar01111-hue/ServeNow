import 'package:customer/core/constants/booking_status.dart';
import 'package:customer/core/router/app_routes.dart';
import 'package:customer/core/widgets/shimmer_loader.dart';
import 'package:customer/features/booking/domain/entities/booking_entity.dart';
import 'package:customer/features/booking/presentation/providers/booking_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MyBookingsScreen extends ConsumerWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookings = ref.watch(myBookingsProvider);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Bookings'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'Ongoing'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: bookings.when(
          data: (items) => TabBarView(
            children: [
              _BookingList(items: items.where((b) => b.status == BookingStatuses.pending || b.status == BookingStatuses.confirmed).toList()),
              _BookingList(items: items.where((b) => 
                b.status == BookingStatuses.assigned || 
                b.status == BookingStatuses.enRoute || 
                b.status == BookingStatuses.arrived || 
                b.status == BookingStatuses.inProgress
              ).toList()),
              _BookingList(items: items.where((b) => b.status == BookingStatuses.completed).toList()),
              _BookingList(items: items.where((b) => b.status == BookingStatuses.cancelled).toList()),
            ],
          ),
          loading: () => const Padding(
            padding: EdgeInsets.all(16),
            child: ShimmerLoader(),
          ),
          error: (e, st) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text('Something went wrong: $e', textAlign: TextAlign.center),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.invalidate(myBookingsProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BookingList extends StatelessWidget {
  const _BookingList({required this.items});
  final List<BookingEntity> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const Center(child: Text('No bookings found'));
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final booking = items[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            title: Text(booking.serviceName),
            subtitle: Text('${booking.scheduledDate.toString().split(' ')[0]} • ${booking.status.toUpperCase().replaceAll('_', ' ')}'),
            trailing: Text('₹${booking.amount}', style: const TextStyle(fontWeight: FontWeight.bold)),
            onTap: () => context.push(AppRoutes.bookingDetailPath(booking.id)),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/core/router/app_routes.dart';
import 'package:provider/core/theme/app_colors.dart';
import 'package:provider/core/widgets/shimmer_loader.dart';
import 'package:provider/features/bookings/domain/entities/booking_entity.dart';
import 'package:provider/features/bookings/presentation/providers/bookings_providers.dart';
import 'package:provider/features/profile/presentation/providers/profile_providers.dart';
import 'package:intl/intl.dart';

class BookingsScreen extends ConsumerWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingAsync = ref.watch(pendingBookingsProvider);
    final activeAsync = ref.watch(activeBookingsProvider);
    final completedAsync = ref.watch(completedBookingsProvider);
    final cancelledAsync = ref.watch(cancelledBookingsProvider);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('My Bookings', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: AppColors.primary,
            indicatorWeight: 3,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', fontSize: 14),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Poppins', fontSize: 14),
            tabs: [
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('New Requests'),
                    pendingAsync.when(
                      data: (bookings) {
                        if (bookings.isEmpty) return const SizedBox.shrink();
                        return Container(
                          margin: const EdgeInsets.only(left: 6),
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
                          constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                          child: Text('${bookings.length}', style: const TextStyle(color: Colors.white, fontSize: 10)),
                        );
                      },
                      loading: () => const SizedBox.shrink(),
                      error: (_, __) => const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
              const Tab(text: 'Active'),
              const Tab(text: 'Completed'),
              const Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _BookingList(asyncValue: pendingAsync, emptyMessage: 'No new requests'),
            _BookingList(asyncValue: activeAsync, emptyMessage: 'No active bookings'),
            _BookingList(asyncValue: completedAsync, emptyMessage: 'No completed bookings'),
            _BookingList(asyncValue: cancelledAsync, emptyMessage: 'No cancelled bookings'),
          ],
        ),
      ),
    );
  }
}

class _BookingList extends ConsumerWidget {
  const _BookingList({required this.asyncValue, required this.emptyMessage});
  final AsyncValue<List<BookingEntity>> asyncValue;
  final String emptyMessage;

  Color _getStatusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.pending: return AppColors.warning;
      case BookingStatus.confirmed: return AppColors.info;
      case BookingStatus.assigned: return AppColors.secondary;
      case BookingStatus.en_route: return AppColors.primaryLight;
      case BookingStatus.arrived: return AppColors.success;
      case BookingStatus.in_progress: return AppColors.secondary;
      case BookingStatus.completed: return AppColors.success;
      case BookingStatus.cancelled: return AppColors.error;
    }
  }

  String _getStatusLabel(BookingStatus status) {
    switch (status) {
      case BookingStatus.pending: return 'PENDING';
      case BookingStatus.confirmed: return 'CONFIRMED';
      case BookingStatus.assigned: return 'ASSIGNED';
      case BookingStatus.en_route: return 'EN ROUTE';
      case BookingStatus.arrived: return 'ARRIVED';
      case BookingStatus.in_progress: return 'IN PROGRESS';
      case BookingStatus.completed: return 'COMPLETED';
      case BookingStatus.cancelled: return 'CANCELLED';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return asyncValue.when(
      data: (bookings) {
        if (bookings.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.event_busy_rounded, size: 64, color: AppColors.textHint.withOpacity(0.3)),
                const SizedBox(height: 16),
                Text(
                  emptyMessage,
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 16, fontFamily: 'Poppins'),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: bookings.length,
          itemBuilder: (context, index) {
            final booking = bookings[index];
            final statusColor = _getStatusColor(booking.status);

            return GestureDetector(
              onTap: () => context.push(AppRoutes.bookingDetailPath(booking.id)),
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      booking.serviceName,
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: statusColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      _getStatusLabel(booking.status),
                                      style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.person_outline_rounded, size: 14, color: AppColors.textSecondary),
                                  const SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      booking.customerName,
                                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, fontFamily: 'Poppins'),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Spacer(),
                                  Flexible(
                                    child: Text(
                                      '₹${booking.amount.toStringAsFixed(0)}',
                                      style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.access_time_rounded, size: 14, color: AppColors.textHint),
                                  const SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      DateFormat('MMM d, yyyy • h:mm a').format(booking.scheduledDate),
                                      style: const TextStyle(color: AppColors.textHint, fontSize: 12, fontFamily: 'Poppins'),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              if (booking.status == BookingStatus.pending) ...[
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () => ref.read(bookingStatusProvider.notifier).updateStatus(booking.id, BookingStatus.cancelled),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: AppColors.error,
                                          side: const BorderSide(color: AppColors.error),
                                          padding: const EdgeInsets.symmetric(vertical: 8),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        ),
                                        child: const Text('Decline', style: TextStyle(fontSize: 13, fontFamily: 'Poppins')),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (booking.providerId.isEmpty) {
                                            final profile = ref.read(providerProfileProvider).value;
                                            if (profile != null) {
                                              ref.read(bookingStatusProvider.notifier).claimBooking(
                                                booking.id,
                                                profile.id,
                                                profile.businessName,
                                              );
                                            }
                                          } else {
                                            ref.read(bookingStatusProvider.notifier).updateStatus(booking.id, BookingStatus.confirmed);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.success,
                                          padding: const EdgeInsets.symmetric(vertical: 8),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        ),
                                        child: const Text('Accept', style: TextStyle(fontSize: 13, fontFamily: 'Poppins')),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      loading: () => const ShimmerLoader(),
      error: (e, st) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: AppColors.error, size: 48),
            const SizedBox(height: 16),
            Text('Something went wrong: $e', textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'Poppins')),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.invalidate(bookingsProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

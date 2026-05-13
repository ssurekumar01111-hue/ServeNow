import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/core/router/app_routes.dart';
import 'package:provider/core/theme/app_colors.dart';
import 'package:provider/core/widgets/shimmer_loader.dart';
import 'package:provider/features/bookings/domain/entities/booking_entity.dart';
import 'package:provider/features/bookings/presentation/providers/bookings_providers.dart';
import 'package:provider/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:provider/features/notifications/presentation/providers/notifications_providers.dart';
import 'package:provider/features/profile/presentation/providers/profile_providers.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(dashboardStatsProvider);
    final profileAsync = ref.watch(providerProfileProvider);
    final pendingBookingsAsync = ref.watch(pendingBookingsProvider);
    final unreadCount = ref.watch(unreadNotificationsCountProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Gradient Header with Greeting and Stats
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(top: 60, bottom: 24, left: 24, right: 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.primaryGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      profileAsync.when(
                        data: (profile) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _getGreeting(),
                              style: const TextStyle(color: Colors.white70, fontSize: 14, fontFamily: 'Poppins'),
                            ),
                            Text(
                              profile?.businessName ?? 'Provider',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        loading: () => const CircularProgressIndicator(color: Colors.white),
                        error: (_, __) => const Flexible(
                          child: Text(
                            'Welcome Back',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.notifications_none_rounded, color: Colors.white),
                              onPressed: () => context.push(AppRoutes.notifications),
                            ),
                          ),
                          if (unreadCount > 0)
                            Positioned(
                              right: 6,
                              top: 6,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
                                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                                child: Text(
                                  '$unreadCount',
                                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Stats Grid 2x2
                  statsAsync.when(
                    data: (stats) => Column(
                      children: [
                        Row(
                          children: [
                            _StatCard(
                              label: 'Today Bookings',
                              value: '${stats.todayBookings}',
                              icon: Icons.calendar_today_rounded,
                              color: AppColors.info,
                            ),
                            const SizedBox(width: 16),
                            _StatCard(
                              label: 'Today Earnings',
                              value: '₹${stats.todayEarnings.toStringAsFixed(0)}',
                              icon: Icons.account_balance_wallet_rounded,
                              color: AppColors.success,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _StatCard(
                              label: 'Total Rating',
                              value: '${stats.averageRating.toStringAsFixed(1)}',
                              icon: Icons.star_rounded,
                              color: AppColors.secondary,
                            ),
                            const SizedBox(width: 16),
                            _StatCard(
                              label: 'Pending Requests',
                              value: '${stats.pendingBookings}',
                              icon: Icons.pending_actions_rounded,
                              color: AppColors.warning,
                            ),
                          ],
                        ),
                      ],
                    ),
                    loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),

          // Pending Bookings Section
          SliverToBoxAdapter(
            child: pendingBookingsAsync.when(
              data: (pendingBookings) {
                if (pendingBookings.isEmpty) return const SizedBox.shrink();
                
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(24, 32, 24, 16),
                      child: Text(
                        'Pending Requests',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        itemCount: pendingBookings.length,
                        itemBuilder: (context, index) {
                          final booking = pendingBookings[index];
                          return _PendingBookingCard(booking: booking, ref: ref);
                        },
                      ),
                    ),
                  ],
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ),

          // Quick Actions Row
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 32, 24, 16),
              child: Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverToBoxAdapter(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _QuickActionItem(
                      icon: Icons.add_circle_outline_rounded,
                      label: 'Add Service',
                      onTap: () => context.push(AppRoutes.addService),
                    ),
                    _QuickActionItem(
                      icon: Icons.bar_chart_rounded,
                      label: 'Earnings',
                      onTap: () => context.push(AppRoutes.earnings),
                    ),                    _QuickActionItem(
                      icon: Icons.account_balance_wallet_outlined,
                      label: 'Withdraw',
                      onTap: () => context.push(AppRoutes.withdrawal),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PendingBookingCard extends StatelessWidget {
  final BookingEntity booking;
  final WidgetRef ref;

  const _PendingBookingCard({required this.booking, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.serviceName,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Poppins'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      booking.customerName,
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, fontFamily: 'Poppins'),
                    ),
                  ],
                ),
              ),
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
          const Spacer(),
          Row(
            children: [
              const Icon(Icons.access_time, size: 14, color: AppColors.textHint),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  DateFormat('MMM d, h:mm a').format(booking.scheduledDate),
                  style: const TextStyle(color: AppColors.textHint, fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
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
                  ),
                  child: const Text('Decline', style: TextStyle(fontSize: 13)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => ref.read(bookingStatusProvider.notifier).updateStatus(booking.id, BookingStatus.confirmed),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: const Text('Accept', style: TextStyle(fontSize: 13)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 100,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primary.withOpacity(0.05)),
          ),
          child: Column(
            children: [
              Icon(icon, color: AppColors.primary, size: 28),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

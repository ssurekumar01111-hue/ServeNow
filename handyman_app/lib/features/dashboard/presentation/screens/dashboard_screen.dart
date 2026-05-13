import 'package:handyman/core/constants/booking_status.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:handyman/core/router/app_routes.dart';
import 'package:handyman/core/providers/firebase_providers.dart';
import 'package:handyman/core/theme/app_colors.dart';
import 'package:handyman/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:handyman/features/jobs/data/models/booking_model.dart';
import 'package:handyman/features/notifications/presentation/providers/notifications_providers.dart';
import 'package:handyman/features/profile/presentation/providers/profile_providers.dart';
import 'package:handyman/features/profile/domain/entities/handyman_profile_entity.dart';
import 'package:handyman/core/utils/navigation_utils.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(handymanProfileProvider);
    final stats = ref.watch(todayStatsProvider);
    final activeJob = ref.watch(activeJobProvider);
    final unreadCount = ref.watch(unreadNotificationsCountProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context, profileAsync, unreadCount),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOnlineToggleCard(context, profileAsync, stats),
                _buildActiveJobCard(context, activeJob),
                _buildDebugCard(ref),
                _buildStatsSection(stats),
                const SizedBox(height: 100), // Space for bottom nav
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveJobCard(BuildContext context, BookingModel? job) {
    if (job == null) return const SizedBox.shrink();

    return FadeInDown(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.primaryGradient,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.work_history, color: Colors.white, size: 24),
                const SizedBox(width: 12),
                const Text(
                  'Active Job',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                  ),
                ),
                const Spacer(),
                _buildStatusChip(job.status),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              job.serviceName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.white70, size: 16),
                const SizedBox(width: 4),
                Text(
                  job.customerArea,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => navigateToCustomer(job),
                    icon: const Icon(Icons.navigation, size: 16),
                    label: const Text('Navigate to Customer'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => context.push(AppRoutes.jobDetailPath(job.id)),
                    icon: const Icon(Icons.visibility, color: Colors.white, size: 16),
                    label: const Text('View Details', style: TextStyle(color: Colors.white)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white54),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case BookingStatuses.assigned: color = Colors.blue; break;
      case BookingStatuses.enRoute: color = Colors.orange; break;
      case BookingStatuses.arrived: color = Colors.purple; break;
      case BookingStatuses.inProgress: color = Colors.white; break;
      default: color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: status == BookingStatuses.inProgress ? Colors.white.withOpacity(0.2) : color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: status == BookingStatuses.inProgress ? Colors.white70 : color, width: 1),
      ),
      child: Text(
        status.replaceAll('_', ' ').toUpperCase(),
        style: TextStyle(
          color: status == BookingStatuses.inProgress ? Colors.white : color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, AsyncValue<HandymanProfileEntity?> profileAsync, int unreadCount) {
    return SliverAppBar(
      expandedHeight: 180.0,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.primary,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AppColors.primaryGradient,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FadeInLeft(
                        child: profileAsync.when(
                          data: (p) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome Back,',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                p?.name ?? 'Partner',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          loading: () => const SizedBox(height: 40),
                          error: (e, st) => const Text('Hello', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      FadeInRight(
                        child: GestureDetector(
                          onTap: () => context.push(AppRoutes.notifications),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Badge(
                              label: unreadCount > 0 ? Text('$unreadCount') : null,
                              isLabelVisible: unreadCount > 0,
                              child: const Icon(Icons.notifications_none, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
    );
  }

  Widget _buildOnlineToggleCard(BuildContext context, AsyncValue<HandymanProfileEntity?> profileAsync, Map<String, num> stats) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: FadeInUp(
        child: profileAsync.when(
          data: (p) {
            final isOnline = p?.isOnline ?? false;
            return Card(
              elevation: 8,
              shadowColor: isOnline ? AppColors.primary.withOpacity(0.3) : Colors.black12,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: isOnline ? Colors.white : Colors.grey.shade100,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isOnline ? AppColors.primary.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isOnline ? Icons.flash_on : Icons.flash_off,
                            color: isOnline ? AppColors.primary : Colors.grey,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isOnline ? "You're Online" : "You're Offline",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isOnline ? AppColors.primary : Colors.grey.shade700,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                isOnline ? "Ready to accept jobs" : "Go online to see jobs",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Consumer(builder: (context, ref, child) {
                          return Switch(
                            value: isOnline,
                            activeColor: AppColors.primary,
                            onChanged: (v) => ref.read(profileNotifierProvider.notifier).toggleOnline(v),
                          );
                        }),
                      ],
                    ),
                    const Divider(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildQuickStat(context, "Today's Jobs", "${(stats['todayCount'] ?? 0).toInt()}"),
                        Container(height: 30, width: 1, color: Colors.grey.shade200),
                        _buildQuickStat(context, "Wallet Balance", "₹${p?.walletBalance.toStringAsFixed(2) ?? '0.00'}"),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => const SizedBox(height: 150, child: Center(child: CircularProgressIndicator())),
          error: (e, st) => const SizedBox(height: 150, child: Center(child: Text('Error loading profile'))),
        ),
      ),
    );
  }

  Widget _buildDebugCard(WidgetRef ref) {
    final user = ref.watch(firebaseAuthProvider).currentUser;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.yellow.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.orange.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('🐞 Debug Info', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 4),
            Text('Auth UID: ${user?.uid}', style: const TextStyle(fontSize: 10, fontFamily: 'monospace')),
            Text('Phone: ${user?.phoneNumber}', style: const TextStyle(fontSize: 10, fontFamily: 'monospace')),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStat(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection(Map<String, num> stats) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Overall Performance",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildLargeStatCard('Assigned', '${stats['totalAssigned'] ?? 0}', Icons.assignment, Colors.blue),
              const SizedBox(width: 12),
              _buildLargeStatCard('Completed', '${stats['totalCompleted'] ?? 0}', Icons.check_circle, Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLargeStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

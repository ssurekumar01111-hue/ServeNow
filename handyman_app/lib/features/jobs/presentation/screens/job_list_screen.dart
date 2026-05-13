import 'package:handyman/core/constants/booking_status.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:handyman/core/router/app_routes.dart';
import 'package:handyman/core/theme/app_colors.dart';
import 'package:handyman/features/jobs/data/models/booking_model.dart';
import 'package:handyman/features/jobs/presentation/providers/jobs_providers.dart';
import 'package:intl/intl.dart';

class JobListScreen extends ConsumerWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'My Jobs',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            labelColor: AppColors.primary,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppColors.primary,
            indicatorWeight: 3,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', fontSize: 13),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Poppins', fontSize: 13),
            tabs: const [
              Tab(text: 'Assigned'),
              Tab(text: 'Active'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _JobTabList(provider: assignedJobsProvider, emptyMessage: "No assigned jobs"),
            _JobTabList(provider: activeJobsProvider, emptyMessage: "No active jobs"),
            _JobTabList(provider: completedJobsProvider, emptyMessage: "No completed jobs"),
            _JobTabList(provider: cancelledJobsProvider, emptyMessage: "No cancelled jobs"),
          ],
        ),
      ),
    );
  }
}

class _JobTabList extends ConsumerWidget {
  const _JobTabList({required this.provider, required this.emptyMessage});
  final StreamProvider<List<BookingModel>> provider;
  final String emptyMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsAsync = ref.watch(provider);

    return jobsAsync.when(
      data: (jobs) {
        if (jobs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.assignment_late_outlined, size: 64, color: Colors.grey.shade300),
                const SizedBox(height: 16),
                Text(
                  emptyMessage,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 16, fontFamily: 'Poppins'),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: jobs.length,
          itemBuilder: (context, index) {
            return FadeInUp(
              duration: Duration(milliseconds: 400 + (index * 100)),
              child: _JobCard(job: jobs[index]),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }
}

class _JobCard extends StatelessWidget {
  const _JobCard({required this.job});
  final BookingModel job;

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(job.status);
    final scheduledDate = job.scheduledDate?.toDate() ?? DateTime.now();
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: statusColor.withOpacity(0.2), width: 1),
      ),
      child: InkWell(
        onTap: () => context.push(AppRoutes.jobDetailPath(job.id)),
        borderRadius: BorderRadius.circular(16),
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
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              job.status.toUpperCase(),
                              style: TextStyle(
                                color: statusColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          Text(
                            DateFormat('dd MMM, hh:mm a').format(scheduledDate),
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  job.serviceName.isNotEmpty ? job.serviceName : 'Service',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.person_outline, size: 14, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(
                                      job.customerName.isNotEmpty ? job.customerName : 'Customer',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade700,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '₹${job.handymanEarning.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              job.customerArea.isNotEmpty ? job.customerArea : 'Location not set',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontFamily: 'Poppins',
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: Colors.grey),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case BookingStatuses.assigned: return AppColors.info;
      case BookingStatuses.enRoute: return AppColors.warning;
      case BookingStatuses.arrived: return Colors.orange;
      case BookingStatuses.inProgress: return AppColors.secondary;
      case BookingStatuses.completed: return AppColors.success;
      case BookingStatuses.cancelled: return AppColors.error;
      default: return Colors.grey;
    }
  }
}

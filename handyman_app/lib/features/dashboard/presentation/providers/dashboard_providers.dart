import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/core/constants/booking_status.dart';
import 'package:handyman/features/jobs/data/models/booking_model.dart';
import 'package:handyman/features/jobs/presentation/providers/jobs_providers.dart';

final Provider<Map<String, num>> todayStatsProvider = Provider((ref) {
  final jobsAsync = ref.watch(jobsProvider);
  
  return jobsAsync.when(
    data: (jobs) {
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      
      final todayJobs = jobs.where((j) {
        final date = j.createdAt?.toDate();
        // date is today if it's not before start of today
        return date != null && !date.isBefore(startOfDay);
      }).toList();
      
      return {
        'todayCount': todayJobs.where((j) => [
          BookingStatuses.assigned,
          BookingStatuses.enRoute,
          BookingStatuses.arrived,
          BookingStatuses.inProgress,
          BookingStatuses.completed,
        ].contains(j.status)).length,
        'assigned': todayJobs.where((j) => j.status == BookingStatuses.assigned).length,
        'completed': todayJobs.where((j) => j.status == BookingStatuses.completed).length,
        'earnings': todayJobs.where((j) => j.status == BookingStatuses.completed).fold(0.0, (sum, j) => sum + j.handymanEarning),
        'totalAssigned': jobs.where((j) => j.status != BookingStatuses.cancelled).length,
        'totalCompleted': jobs.where((j) => j.status == BookingStatuses.completed).length,
      };
    },
    loading: () => {
      'todayCount': 0,
      'assigned': 0, 
      'completed': 0, 
      'earnings': 0, 
      'totalAssigned': 0, 
      'totalCompleted': 0
    },
    error: (_, __) => {
      'todayCount': 0,
      'assigned': 0, 
      'completed': 0, 
      'earnings': 0, 
      'totalAssigned': 0, 
      'totalCompleted': 0
    },
  );
});

final activeJobProvider = Provider<BookingModel?>((ref) {
  final jobsAsync = ref.watch(jobsProvider);
  return jobsAsync.maybeWhen(
    data: (jobs) => jobs.where((j) => [
      BookingStatuses.assigned,
      BookingStatuses.enRoute,
      BookingStatuses.arrived,
      BookingStatuses.inProgress
    ].contains(j.status)).firstOrNull,
    orElse: () => null,
  );
});

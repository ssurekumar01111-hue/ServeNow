import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/core/constants/booking_status.dart';
import 'package:handyman/core/providers/firebase_providers.dart';
import 'package:handyman/features/auth/presentation/providers/auth_provider.dart';
import 'package:handyman/features/earnings/data/wallet_repository.dart';
import 'package:handyman/features/jobs/data/datasources/jobs_remote_datasource.dart';
import 'package:handyman/features/jobs/data/datasources/location_update_service.dart';
import 'package:handyman/features/jobs/data/models/booking_model.dart';
import 'package:handyman/features/jobs/domain/entities/job_entity.dart';

final jobsRemoteDataSourceProvider = Provider<JobsRemoteDataSource>((ref) {
  return JobsRemoteDataSourceImpl(
    ref.watch(firestoreProvider),
    ref.watch(firebaseStorageProvider),
  );
});

final locationUpdateServiceProvider = Provider<LocationUpdateService>((ref) {
  return LocationUpdateService(ref.watch(firestoreProvider));
});

final jobsProvider = StreamProvider<List<BookingModel>>((ref) {
  final user = ref.watch(authNotifierProvider).value;
  if (user == null) return Stream.value([]);
  return ref.watch(jobsRemoteDataSourceProvider).getJobs(user.uid);
});

final assignedJobsProvider = StreamProvider<List<BookingModel>>((ref) {
  final user = ref.watch(authNotifierProvider).value;
  if (user == null) return Stream.value([]);
  return ref.watch(jobsRemoteDataSourceProvider).getJobsByStatus(user.uid, BookingStatuses.assigned);
});

final activeJobsProvider = StreamProvider<List<BookingModel>>((ref) {
  final user = ref.watch(authNotifierProvider).value;
  if (user == null) return Stream.value([]);
  return ref.watch(jobsRemoteDataSourceProvider).getActiveJobs(user.uid);
});

final completedJobsProvider = StreamProvider<List<BookingModel>>((ref) {
  final user = ref.watch(authNotifierProvider).value;
  if (user == null) return Stream.value([]);
  return ref.watch(jobsRemoteDataSourceProvider).getJobsByStatus(user.uid, BookingStatuses.completed);
});

final cancelledJobsProvider = StreamProvider<List<BookingModel>>((ref) {
  final user = ref.watch(authNotifierProvider).value;
  if (user == null) return Stream.value([]);
  return ref.watch(jobsRemoteDataSourceProvider).getJobsByStatus(user.uid, BookingStatuses.cancelled);
});

final jobStatusProvider = AsyncNotifierProvider<JobStatusNotifier, void>(JobStatusNotifier.new);

class JobStatusNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> updateStatus(String jobId, JobStatus status, {Map<String, dynamic>? extraData}) async {
    state = const AsyncLoading();
    try {
      final user = ref.read(authNotifierProvider).value!;
      
      final Map<String, dynamic> data = Map.from(extraData ?? {});
      if (status == JobStatus.enRoute) data['enRouteAt'] = FieldValue.serverTimestamp();
      if (status == JobStatus.arrived) data['arrivedAt'] = FieldValue.serverTimestamp();
      if (status == JobStatus.inProgress) data['startedAt'] = FieldValue.serverTimestamp();
      if (status == JobStatus.completed) data['completedAt'] = FieldValue.serverTimestamp();

      await ref.read(jobsRemoteDataSourceProvider).updateJobStatus(jobId, status, extraData: data);
      
      final locationService = ref.read(locationUpdateServiceProvider);
      if (status == JobStatus.enRoute) {
        await locationService.startTracking(user.uid, jobId);
      } else if (status == JobStatus.completed || status == JobStatus.cancelled) {
        locationService.stopTracking();
      }
      
      // If completed, location tracking is stopped automatically via the logic above
      
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> collectCash(String jobId, double amount) async {
    state = const AsyncLoading();
    try {
      final user = ref.read(authNotifierProvider).value!;
      await ref.read(jobsRemoteDataSourceProvider).collectCash(jobId, amount, user.uid);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> completeJob(String jobId, File afterPhoto, {double? additionalCharges, String? notes}) async {
    state = const AsyncLoading();
    try {
      final url = await ref.read(jobsRemoteDataSourceProvider).uploadJobPhoto(jobId, 'after', afterPhoto);
      await updateStatus(jobId, JobStatus.completed, extraData: {
        'afterPhotoUrl': url,
        'additionalCharges': additionalCharges,
        'additionalNotes': notes,
      });
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> startJob(String jobId, File beforePhoto) async {
    state = const AsyncLoading();
    try {
      final url = await ref.read(jobsRemoteDataSourceProvider).uploadJobPhoto(jobId, 'before', beforePhoto);
      await updateStatus(jobId, JobStatus.inProgress, extraData: {
        'beforePhotoUrl': url,
      });
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

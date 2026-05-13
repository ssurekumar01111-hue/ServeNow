import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/core/providers/firebase_providers.dart';
import 'package:provider/features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:provider/features/dashboard/data/models/dashboard_stats.dart';

final dashboardRemoteDataSourceProvider = Provider<DashboardRemoteDataSource>((ref) {
  return DashboardRemoteDataSourceImpl(ref.watch(firestoreProvider));
});

final dashboardStatsProvider = StreamProvider<DashboardStats>((ref) {
  final user = ref.watch(authNotifierProvider).value;
  if (user == null) return const Stream.empty();
  return ref.watch(dashboardRemoteDataSourceProvider).getStats(user.uid);
});

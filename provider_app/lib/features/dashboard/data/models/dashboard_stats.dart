import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_stats.freezed.dart';
part 'dashboard_stats.g.dart';

@freezed
abstract class DashboardStats with _$DashboardStats {
  const factory DashboardStats({
    required int todayBookings,
    required double todayEarnings,
    required double averageRating,
    required int pendingBookings,
  }) = _DashboardStats;

  const DashboardStats._();

  factory DashboardStats.fromJson(Map<String, dynamic> json) => _$DashboardStatsFromJson(json);
}

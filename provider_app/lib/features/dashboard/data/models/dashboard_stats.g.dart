// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DashboardStats _$DashboardStatsFromJson(Map<String, dynamic> json) =>
    _DashboardStats(
      todayBookings: (json['todayBookings'] as num).toInt(),
      todayEarnings: (json['todayEarnings'] as num).toDouble(),
      averageRating: (json['averageRating'] as num).toDouble(),
      pendingBookings: (json['pendingBookings'] as num).toInt(),
    );

Map<String, dynamic> _$DashboardStatsToJson(_DashboardStats instance) =>
    <String, dynamic>{
      'todayBookings': instance.todayBookings,
      'todayEarnings': instance.todayEarnings,
      'averageRating': instance.averageRating,
      'pendingBookings': instance.pendingBookings,
    };

import 'package:handyman/core/constants/booking_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_entity.freezed.dart';

enum JobStatus {
  assigned,
  enRoute,
  arrived,
  inProgress,
  completed,
  cancelled;

  String get dbValue {
    switch (this) {
      case JobStatus.enRoute:
        return BookingStatuses.enRoute;
      case JobStatus.inProgress:
        return BookingStatuses.inProgress;
      case JobStatus.assigned:
        return BookingStatuses.assigned;
      case JobStatus.arrived:
        return BookingStatuses.arrived;
      case JobStatus.completed:
        return BookingStatuses.completed;
      case JobStatus.cancelled:
        return BookingStatuses.cancelled;
      default:
        return name;
    }
  }
}

@freezed
abstract class JobEntity with _$JobEntity {
  const factory JobEntity({
    required String id,
    required String customerId,
    required String customerName,
    required String serviceName,
    required String address,
    required String area,
    required DateTime scheduledAt,
    required double amount,
    @Default(0.0) double handymanEarning,
    @Default(0.0) double handymanCommissionRate,
    required JobStatus status,
    required String otp,
    required String paymentMethod, // 'cash' | 'online'
    double? customerLat,
    double? customerLng,
    String? notes,
    String? beforePhotoUrl,
    String? afterPhotoUrl,
    double? additionalCharges,
    String? additionalNotes,
    DateTime? completedAt,
  }) = _JobEntity;

  const JobEntity._();
}

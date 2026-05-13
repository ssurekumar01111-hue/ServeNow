import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_entity.freezed.dart';

enum BookingStatus {
  pending,
  confirmed,
  assigned,
  en_route,
  arrived,
  in_progress,
  completed,
  cancelled
}

enum PaymentStatus { pending, paid, failed, refunded }

enum PaymentMethod { razorpay, stripe, wallet, cod }

@freezed
abstract class BookingEntity with _$BookingEntity {
  const factory BookingEntity({
    required String id,
    required String customerId,
    required String customerName,
    required String customerPhone,
    required String customerAddress,
    required String customerArea,
    required String providerId,
    required String providerName,
    String? assignedHandymanId,
    String? assignedHandymanName,
    required String serviceId,
    required String serviceName,
    required String serviceCategory,
    required String serviceCategoryId,
    required DateTime scheduledDate,
    required String scheduledTime,
    required BookingStatus status,
    required String otp,
    required double amount,
    required double commission,
    required double providerEarning,
    @Default(0.0) double handymanEarning,
    @Default(0.0) double handymanCommissionRate,
    required PaymentMethod paymentMethod,
    required PaymentStatus paymentStatus,
    String? razorpayOrderId,
    String? razorpayPaymentId,
    String? cancellationReason,
    String? cancelledBy,
    String? couponCode,
    @Default(0.0) double discountAmount,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? completedAt,
    double? rating,
    String? review,
    @Default(false) bool autoAssigned,
    DateTime? autoAssignedAt,
  }) = _BookingEntity;

  const BookingEntity._();
}

import 'package:customer/features/auth/domain/entities/user_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_entity.freezed.dart';

enum PaymentStatus { pending, paid, failed, refunded }

enum PaymentMethod { razorpay, stripe, wallet, cod, online }

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
    required String status,
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
    double? discountAmount,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? completedAt,
    double? rating,
    String? review,
    @Default(false) bool isRated,
    Map<String, DateTime>? statusTimeline,
    double? customerLat,
    double? customerLng,
  }) = _BookingEntity;

  const BookingEntity._();
}

@freezed
abstract class SlotEntity with _$SlotEntity {
  const factory SlotEntity({
    required DateTime dateTime,
    bool? isAvailable,
  }) = _SlotEntity;

  const SlotEntity._();
}

@freezed
abstract class CouponEntity with _$CouponEntity {
  const factory CouponEntity({
    required String code,
    required double discount,
    required String type, // flat | percentage
    required double minOrder,
    required DateTime expiresAt,
    double? maxDiscount,
    bool? isActive,
  }) = _CouponEntity;

  const CouponEntity._();
}

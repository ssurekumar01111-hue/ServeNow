// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookingModel _$BookingModelFromJson(Map<String, dynamic> json) =>
    _BookingModel(
      id: json['id'] as String,
      customerId: json['customerId'] as String,
      customerName: json['customerName'] as String,
      customerPhone: json['customerPhone'] as String,
      customerAddress: json['customerAddress'] as String,
      customerArea: json['customerArea'] as String,
      providerId: json['providerId'] as String,
      providerName: json['providerName'] as String,
      assignedHandymanId: json['assignedHandymanId'] as String?,
      assignedHandymanName: json['assignedHandymanName'] as String?,
      serviceId: json['serviceId'] as String,
      serviceName: json['serviceName'] as String,
      serviceCategory: json['serviceCategory'] as String,
      serviceCategoryId: json['serviceCategoryId'] as String,
      scheduledDate: const TimestampConverter().fromJson(json['scheduledDate']),
      scheduledTime: json['scheduledTime'] as String,
      status: json['status'] as String,
      otp: json['otp'] as String,
      amount: (json['amount'] as num).toDouble(),
      commission: (json['commission'] as num).toDouble(),
      providerEarning: (json['providerEarning'] as num).toDouble(),
      handymanEarning: (json['handymanEarning'] as num?)?.toDouble() ?? 0.0,
      handymanCommissionRate:
          (json['handymanCommissionRate'] as num?)?.toDouble() ?? 0.0,
      paymentMethod: json['paymentMethod'] as String,
      paymentStatus: json['paymentStatus'] as String,
      razorpayOrderId: json['razorpayOrderId'] as String?,
      razorpayPaymentId: json['razorpayPaymentId'] as String?,
      cancellationReason: json['cancellationReason'] as String?,
      cancelledBy: json['cancelledBy'] as String?,
      couponCode: json['couponCode'] as String?,
      discountAmount: (json['discountAmount'] as num).toDouble(),
      notes: json['notes'] as String?,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      completedAt: const OptionalTimestampConverter().fromJson(
        json['completedAt'],
      ),
      rating: (json['rating'] as num?)?.toDouble(),
      review: json['review'] as String?,
      isRated: json['isRated'] as bool? ?? false,
      statusTimeline: json['statusTimeline'] as Map<String, dynamic>?,
      customerLat: (json['customerLat'] as num?)?.toDouble(),
      customerLng: (json['customerLng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$BookingModelToJson(
  _BookingModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'customerId': instance.customerId,
  'customerName': instance.customerName,
  'customerPhone': instance.customerPhone,
  'customerAddress': instance.customerAddress,
  'customerArea': instance.customerArea,
  'providerId': instance.providerId,
  'providerName': instance.providerName,
  'assignedHandymanId': instance.assignedHandymanId,
  'assignedHandymanName': instance.assignedHandymanName,
  'serviceId': instance.serviceId,
  'serviceName': instance.serviceName,
  'serviceCategory': instance.serviceCategory,
  'serviceCategoryId': instance.serviceCategoryId,
  'scheduledDate': const TimestampConverter().toJson(instance.scheduledDate),
  'scheduledTime': instance.scheduledTime,
  'status': instance.status,
  'otp': instance.otp,
  'amount': instance.amount,
  'commission': instance.commission,
  'providerEarning': instance.providerEarning,
  'handymanEarning': instance.handymanEarning,
  'handymanCommissionRate': instance.handymanCommissionRate,
  'paymentMethod': instance.paymentMethod,
  'paymentStatus': instance.paymentStatus,
  'razorpayOrderId': instance.razorpayOrderId,
  'razorpayPaymentId': instance.razorpayPaymentId,
  'cancellationReason': instance.cancellationReason,
  'cancelledBy': instance.cancelledBy,
  'couponCode': instance.couponCode,
  'discountAmount': instance.discountAmount,
  'notes': instance.notes,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'completedAt': const OptionalTimestampConverter().toJson(
    instance.completedAt,
  ),
  'rating': instance.rating,
  'review': instance.review,
  'isRated': instance.isRated,
  'statusTimeline': instance.statusTimeline,
  'customerLat': instance.customerLat,
  'customerLng': instance.customerLng,
};

_CouponModel _$CouponModelFromJson(Map<String, dynamic> json) => _CouponModel(
  code: json['code'] as String,
  discount: (json['discount'] as num).toDouble(),
  type: json['type'] as String,
  minOrder: (json['minOrder'] as num).toDouble(),
  expiresAt: const TimestampConverter().fromJson(json['expiresAt']),
  maxDiscount: (json['maxDiscount'] as num?)?.toDouble(),
  isActive: json['isActive'] as bool?,
);

Map<String, dynamic> _$CouponModelToJson(_CouponModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'discount': instance.discount,
      'type': instance.type,
      'minOrder': instance.minOrder,
      'expiresAt': const TimestampConverter().toJson(instance.expiresAt),
      'maxDiscount': instance.maxDiscount,
      'isActive': instance.isActive,
    };

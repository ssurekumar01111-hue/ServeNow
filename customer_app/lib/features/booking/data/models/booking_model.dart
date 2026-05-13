import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/features/booking/domain/entities/booking_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_model.freezed.dart';
part 'booking_model.g.dart';

@freezed
abstract class BookingModel with _$BookingModel {
  const factory BookingModel({
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
    @TimestampConverter() required DateTime scheduledDate,
    required String scheduledTime,
    required String status,
    required String otp,
    required double amount,
    required double commission,
    required double providerEarning,
    @Default(0.0) double handymanEarning,
    @Default(0.0) double handymanCommissionRate,
    required String paymentMethod,
    required String paymentStatus,
    String? razorpayOrderId,
    String? razorpayPaymentId,
    String? cancellationReason,
    String? cancelledBy,
    String? couponCode,
    required double discountAmount,
    String? notes,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    @OptionalTimestampConverter() DateTime? completedAt,
    double? rating,
    String? review,
    @Default(false) bool isRated,
    Map<String, dynamic>? statusTimeline,
    double? customerLat,
    double? customerLng,
  }) = _BookingModel;

  const BookingModel._();

  static bool _bool(dynamic v, [bool d = false]) =>
      v == null ? d : (v is bool ? v : v.toString() == 'true');

  static DateTime _parseTimestamp(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is Timestamp) return value.toDate();
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (_) {
        return DateTime.now();
      }
    }
    return DateTime.now();
  }

  static DateTime? _parseOptionalTimestamp(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  // Handle both bool and string
  static String _parsePaymentStatus(dynamic value) {
    if (value == null) return 'pending';
    if (value is bool) {
      return value ? 'paid' : 'pending';
    }
    return value.toString();
  }

  factory BookingModel.fromEntity(BookingEntity entity) => BookingModel(
        id: entity.id,
        customerId: entity.customerId,
        customerName: entity.customerName,
        customerPhone: entity.customerPhone,
        customerAddress: entity.customerAddress,
        customerArea: entity.customerArea,
        providerId: entity.providerId,
        providerName: entity.providerName,
        assignedHandymanId: entity.assignedHandymanId,
        assignedHandymanName: entity.assignedHandymanName,
        serviceId: entity.serviceId,
        serviceName: entity.serviceName,
        serviceCategory: entity.serviceCategory,
        serviceCategoryId: entity.serviceCategoryId,
        scheduledDate: entity.scheduledDate,
        scheduledTime: entity.scheduledTime,
        status: entity.status,
        otp: entity.otp,
        amount: entity.amount,
        commission: entity.commission,
        providerEarning: entity.providerEarning,
        handymanEarning: entity.handymanEarning,
        handymanCommissionRate: entity.handymanCommissionRate,
        paymentMethod: entity.paymentMethod.name,
        paymentStatus: entity.paymentStatus.name,
        razorpayOrderId: entity.razorpayOrderId,
        razorpayPaymentId: entity.razorpayPaymentId,
        cancellationReason: entity.cancellationReason,
        cancelledBy: entity.cancelledBy,
        couponCode: entity.couponCode,
        discountAmount: entity.discountAmount ?? 0.0,
        notes: entity.notes,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        completedAt: entity.completedAt,
        rating: entity.rating,
        review: entity.review,
        isRated: entity.isRated,
        statusTimeline: entity.statusTimeline?.map((k, v) => MapEntry(k, Timestamp.fromDate(v))),
        customerLat: entity.customerLat,
        customerLng: entity.customerLng,
      );

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json['id'] as String? ?? '',
        customerId: json['customerId'] as String? ?? '',
        customerName: json['customerName'] as String? ?? '',
        customerPhone: json['customerPhone'] as String? ?? '',
        customerAddress: json['customerAddress'] as String? ?? '',
        customerArea: json['customerArea'] as String? ?? '',
        providerId: json['providerId'] as String? ?? '',
        providerName: json['providerName'] as String? ?? '',
        assignedHandymanId: json['assignedHandymanId'] as String?,
        assignedHandymanName: json['assignedHandymanName'] as String?,
        serviceId: json['serviceId'] as String? ?? '',
        serviceName: json['serviceName'] as String? ?? '',
        serviceCategory: json['serviceCategory'] as String? ?? '',
        serviceCategoryId: json['serviceCategoryId'] as String? ?? '',
        scheduledDate: _parseTimestamp(json['scheduledDate'] ?? json['scheduledAt']),
        scheduledTime: json['scheduledTime'] as String? ?? '',
        status: json['status'] as String? ?? 'pending',
        otp: json['otp'] as String? ?? '',
        amount: (json['amount'] as num? ?? 0.0).toDouble(),
        commission: (json['commission'] as num? ?? 0.0).toDouble(),
        providerEarning: (json['providerEarning'] as num? ?? 0.0).toDouble(),
        handymanEarning: (json['handymanEarning'] as num? ?? 0.0).toDouble(),
        handymanCommissionRate: (json['handymanCommissionRate'] as num? ?? 0.0).toDouble(),
        paymentMethod: json['paymentMethod'] as String? ?? 'cod',
        paymentStatus: _parsePaymentStatus(json['paymentStatus']),
        razorpayOrderId: json['razorpayOrderId'] as String?,
        razorpayPaymentId: json['razorpayPaymentId'] as String?,
        cancellationReason: json['cancellationReason'] as String?,
        cancelledBy: json['cancelledBy'] as String?,
        couponCode: json['couponCode'] as String?,
        discountAmount: (json['discountAmount'] as num? ?? 0.0).toDouble(),
        notes: json['notes'] as String?,
        createdAt: _parseTimestamp(json['createdAt']),
        updatedAt: _parseTimestamp(json['updatedAt']),
        completedAt: _parseOptionalTimestamp(json['completedAt']),
        rating: (json['rating'] as num?)?.toDouble(),
        review: json['review'] as String?,
        isRated: _bool(json['isRated'] ?? json['hasBeenRated']),
        statusTimeline: json['statusTimeline'] as Map<String, dynamic>?,
        customerLat: (json['customerLat'] as num?)?.toDouble(),
        customerLng: (json['customerLng'] as num?)?.toDouble(),
      );

  factory BookingModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return BookingModel.fromJson({
      ...data,
      'id': doc.id,
    });
  }

  BookingEntity toEntity() => BookingEntity(
        id: id,
        customerId: customerId,
        customerName: customerName,
        customerPhone: customerPhone,
        customerAddress: customerAddress,
        customerArea: customerArea,
        providerId: providerId,
        providerName: providerName,
        assignedHandymanId: assignedHandymanId,
        assignedHandymanName: assignedHandymanName,
        serviceId: serviceId,
        serviceName: serviceName,
        serviceCategory: serviceCategory,
        serviceCategoryId: serviceCategoryId,
        scheduledDate: scheduledDate,
        scheduledTime: scheduledTime,
        status: status,
        otp: otp,
        amount: amount,
        commission: commission,
        providerEarning: providerEarning,
        handymanEarning: handymanEarning,
        handymanCommissionRate: handymanCommissionRate,
        paymentMethod: PaymentMethod.values.firstWhere((e) => e.name == paymentMethod, orElse: () => PaymentMethod.cod),
        paymentStatus: PaymentStatus.values.firstWhere((e) => e.name == paymentStatus, orElse: () => PaymentStatus.pending),
        razorpayOrderId: razorpayOrderId,
        razorpayPaymentId: razorpayPaymentId,
        cancellationReason: cancellationReason,
        cancelledBy: cancelledBy,
        couponCode: couponCode,
        discountAmount: discountAmount,
        notes: notes,
        createdAt: createdAt,
        updatedAt: updatedAt,
        completedAt: completedAt,
        rating: rating,
        review: review,
        isRated: isRated,
        statusTimeline: statusTimeline?.map((k, v) => MapEntry(k, (v as Timestamp).toDate())),
        customerLat: customerLat,
        customerLng: customerLng,
      );
}

@freezed
abstract class CouponModel with _$CouponModel {
  const factory CouponModel({
    required String code,
    required double discount,
    required String type,
    required double minOrder,
    @TimestampConverter() required DateTime expiresAt,
    double? maxDiscount,
    bool? isActive,
  }) = _CouponModel;

  const CouponModel._();

  static String _str(dynamic v, [String d = '']) =>
      v == null ? d : v.toString();

  static double _dbl(dynamic v, [double d = 0.0]) =>
      v == null ? d : (v is num ? v.toDouble() : double.tryParse(v.toString()) ?? d);

  static int _int(dynamic v, [int d = 0]) =>
      v == null ? d : (v is num ? v.toInt() : int.tryParse(v.toString()) ?? d);

  static bool _bool(dynamic v, [bool d = false]) =>
      v == null ? d : (v is bool ? v : v.toString() == 'true');

  factory CouponModel.fromJson(Map<String, dynamic> json) =>
      _$CouponModelFromJson(json);

  factory CouponModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return CouponModel(
      code: _str(data['code'] ?? data['discountCode'] ?? doc.id),
      discount: _dbl(data['discountValue'] ?? data['discount']),
      type: _str(data['discountType'] ?? data['type'], 'percentage'),
      minOrder: _dbl(data['minOrderAmount'] ?? data['minOrder']),
      expiresAt: (data['expiryDate'] as Timestamp? ?? data['expiresAt'] as Timestamp? ?? Timestamp.now()).toDate(),
      maxDiscount: data['maxDiscount'] != null ? _dbl(data['maxDiscount']) : null,
      isActive: _bool(data['isActive'], true),
    );
  }

  CouponEntity toEntity() => CouponEntity(
        code: code,
        discount: discount,
        type: type,
        minOrder: minOrder,
        expiresAt: expiresAt,
        maxDiscount: maxDiscount,
        isActive: isActive ?? true,
      );
}

class TimestampConverter implements JsonConverter<DateTime, dynamic> {
  const TimestampConverter();

  @override
  DateTime fromJson(dynamic timestamp) {
    if (timestamp is Timestamp) return timestamp.toDate();
    if (timestamp is String) return DateTime.parse(timestamp);
    return DateTime.now();
  }

  @override
  dynamic toJson(DateTime date) => Timestamp.fromDate(date);
}

class OptionalTimestampConverter implements JsonConverter<DateTime?, dynamic> {
  const OptionalTimestampConverter();

  @override
  DateTime? fromJson(dynamic timestamp) {
    if (timestamp is Timestamp) return timestamp.toDate();
    if (timestamp is String) return DateTime.parse(timestamp);
    return null;
  }

  @override
  dynamic toJson(DateTime? date) => date != null ? Timestamp.fromDate(date) : null;
}

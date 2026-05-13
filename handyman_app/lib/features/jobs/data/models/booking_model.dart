import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String id;
  final String customerId;
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final String customerArea;
  final double customerLat;
  final double customerLng;
  final String providerId;
  final String providerName;
  final String assignedHandymanId;
  final String assignedHandymanName;
  final String serviceId;
  final String serviceName;
  final String serviceCategory;
  final String serviceCategoryId;
  final Timestamp? scheduledDate;
  final String scheduledTime;
  final String status;
  final String otp;
  final double amount;
  final double commission;
  final double providerEarning;
  final double handymanEarning;
  final double handymanCommissionRate;
  final String paymentMethod;
  final String paymentStatus;
  final String? razorpayOrderId;
  final String? razorpayPaymentId;
  final double discountAmount;
  final String? couponCode;
  final String? notes;
  final String? adminNote;
  final String? cancellationReason;
  final String? cancelledBy;
  final bool autoAssigned;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;
  final Timestamp? completedAt;
  final double? rating;
  final String? review;

  BookingModel({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.customerArea,
    required this.customerLat,
    required this.customerLng,
    required this.providerId,
    required this.providerName,
    required this.assignedHandymanId,
    required this.assignedHandymanName,
    required this.serviceId,
    required this.serviceName,
    required this.serviceCategory,
    required this.serviceCategoryId,
    this.scheduledDate,
    required this.scheduledTime,
    required this.status,
    required this.otp,
    required this.amount,
    required this.commission,
    required this.providerEarning,
    this.handymanEarning = 0.0,
    this.handymanCommissionRate = 0.0,
    required this.paymentMethod,
    required this.paymentStatus,
    this.razorpayOrderId,
    this.razorpayPaymentId,
    required this.discountAmount,
    this.couponCode,
    this.notes,
    this.adminNote,
    this.cancellationReason,
    this.cancelledBy,
    required this.autoAssigned,
    this.createdAt,
    this.updatedAt,
    this.completedAt,
    this.rating,
    this.review,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: _str(json['id']),
      customerId: _str(json['customerId']),
      customerName: _str(json['customerName']),
      customerPhone: _str(json['customerPhone']),
      customerAddress: _str(json['customerAddress']),
      customerArea: _str(json['customerArea']),
      customerLat: _dbl(json['customerLat']),
      customerLng: _dbl(json['customerLng']),
      providerId: _str(json['providerId']),
      providerName: _str(json['providerName']),
      assignedHandymanId: _str(json['assignedHandymanId']),
      assignedHandymanName: _str(json['assignedHandymanName']),
      serviceId: _str(json['serviceId']),
      serviceName: _str(json['serviceName']),
      serviceCategory: _str(json['serviceCategory']),
      serviceCategoryId: _str(json['serviceCategoryId']),
      scheduledDate: _ts(json['scheduledDate'] ?? json['scheduledAt']),
      scheduledTime: _str(json['scheduledTime']),
      status: _str(json['status'], fallback: 'pending'),
      otp: _str(json['otp']),
      amount: _dbl(json['amount']),
      commission: _dbl(json['commission']),
      providerEarning: _dbl(json['providerEarning']),
      handymanEarning: _dbl(json['handymanEarning']),
      handymanCommissionRate: _dbl(json['handymanCommissionRate']),
      paymentMethod: _str(json['paymentMethod'], fallback: 'cod'),
      paymentStatus: _parsePaymentStatus(json['paymentStatus']),
      razorpayOrderId: json['razorpayOrderId']?.toString(),
      razorpayPaymentId: json['razorpayPaymentId']?.toString(),
      discountAmount: _dbl(json['discountAmount']),
      couponCode: json['couponCode']?.toString(),
      notes: json['notes']?.toString(),
      adminNote: json['adminNote']?.toString(),
      cancellationReason: json['cancellationReason']?.toString(),
      cancelledBy: json['cancelledBy']?.toString(),
      autoAssigned: json['autoAssigned'] as bool? ?? false,
      createdAt: _ts(json['createdAt']),
      updatedAt: _ts(json['updatedAt']),
      completedAt: _ts(json['completedAt']),
      rating: json['rating'] != null ? _dbl(json['rating']) : null,
      review: json['review']?.toString(),
    );
  }

  // Handle both bool and string
  static String _parsePaymentStatus(dynamic value) {
    if (value == null) return 'pending';
    if (value is bool) {
      return value ? 'paid' : 'pending';
    }
    return value.toString();
  }

  // Safe String parser
  static String _str(dynamic v, {String fallback = ''}) {
    if (v == null) return fallback;
    return v.toString();
  }

  // Safe double parser
  static double _dbl(dynamic v, {double fallback = 0.0}) {
    if (v == null) return fallback;
    if (v is double) return v;
    if (v is int) return v.toDouble();
    if (v is String) return double.tryParse(v) ?? fallback;
    return fallback;
  }

  // Safe Timestamp parser
  static Timestamp? _ts(dynamic v) {
    if (v == null) return null;
    if (v is Timestamp) return v;
    return null;
  }
}

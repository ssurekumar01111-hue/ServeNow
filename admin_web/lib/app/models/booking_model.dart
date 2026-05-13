import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  String? id;
  String? customerId;
  String? providerId;
  String? serviceId;
  String? status;
  double? amount;
  DateTime? scheduledDate;
  DateTime? createdAt;
  String? address;
  String? paymentMethod;
  String? paymentStatus;
  String? razorpayOrderId;
  String? razorpayPaymentId;

  BookingModel({
    this.id,
    this.customerId,
    this.providerId,
    this.serviceId,
    this.status,
    this.amount,
    this.scheduledDate,
    this.createdAt,
    this.address,
    this.paymentMethod,
    this.paymentStatus,
    this.razorpayOrderId,
    this.razorpayPaymentId,
  });

  static DateTime? _parseTimestamp(dynamic value) {
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

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  BookingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    providerId = json['providerId'];
    serviceId = json['serviceId'];
    status = json['status'];
    amount = _parseDouble(json['amount'] ?? json['totalAmount']);
    scheduledDate = _parseTimestamp(json['scheduledDate'] ?? json['scheduledAt']);
    createdAt = _parseTimestamp(json['createdAt']);
    address = json['address'] ?? json['customerAddress'];
    paymentMethod = json['paymentMethod'];
    paymentStatus = json['paymentStatus']?.toString();
    razorpayOrderId = json['razorpayOrderId'];
    razorpayPaymentId = json['razorpayPaymentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customerId'] = customerId;
    data['providerId'] = providerId;
    data['serviceId'] = serviceId;
    data['status'] = status;
    data['amount'] = amount;
    data['scheduledDate'] = scheduledDate != null ? Timestamp.fromDate(scheduledDate!) : null;
    data['createdAt'] = createdAt != null ? Timestamp.fromDate(createdAt!) : null;
    data['address'] = address;
    data['paymentMethod'] = paymentMethod;
    data['paymentStatus'] = paymentStatus;
    data['razorpayOrderId'] = razorpayOrderId;
    data['razorpayPaymentId'] = razorpayPaymentId;
    return data;
  }
}

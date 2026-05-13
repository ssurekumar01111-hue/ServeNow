import 'package:cloud_firestore/cloud_firestore.dart';

class CouponModel {
  String? id;
  String? code;
  double? discountValue;
  String? discountType; // 'percent' or 'flat'
  Timestamp? validFrom;
  Timestamp? validUntil;
  int? usageLimit;
  int? usedCount;
  double? minOrderAmount;
  double? maxDiscount;
  List<String>? applicableCategories;
  bool? isActive;
  Timestamp? createdAt;

  CouponModel({
    this.id,
    this.code,
    this.discountValue,
    this.discountType,
    this.validFrom,
    this.validUntil,
    this.usageLimit,
    this.usedCount,
    this.minOrderAmount,
    this.maxDiscount,
    this.applicableCategories,
    this.isActive,
    this.createdAt,
  });

  CouponModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    discountValue = json['discountValue']?.toDouble() ?? json['discount']?.toDouble();
    discountType = json['discountType'];
    validFrom = json['validFrom'];
    validUntil = json['validUntil'] ?? json['expiryDate'];
    usageLimit = json['usageLimit'];
    usedCount = json['usedCount'];
    minOrderAmount = json['minOrderAmount']?.toDouble();
    maxDiscount = json['maxDiscount']?.toDouble();
    applicableCategories = json['applicableCategories'] != null ? List<String>.from(json['applicableCategories']) : null;
    isActive = json['isActive'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['discountValue'] = discountValue;
    data['discountType'] = discountType;
    data['validFrom'] = validFrom;
    data['validUntil'] = validUntil;
    data['usageLimit'] = usageLimit;
    data['usedCount'] = usedCount;
    data['minOrderAmount'] = minOrderAmount;
    data['maxDiscount'] = maxDiscount;
    data['applicableCategories'] = applicableCategories;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    return data;
  }
}

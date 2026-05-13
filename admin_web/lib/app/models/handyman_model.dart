import 'package:cloud_firestore/cloud_firestore.dart';

class HandymanModel {
  String? id;
  String? fullName;
  String? name;
  String? email;
  String? profileImage;
  String? photoUrl;
  String? idProofUrl;
  String? phoneNumber;
  String? phone;
  String? providerId;
  String? providerName;
  String? serviceArea;
  List<String>? skills;
  String? onboardingStatus;
  bool? isApproved;
  bool? isActive;
  int? commissionRate;
  double? walletBalance;
  double? totalEarnings;
  int? totalJobs;
  int? completedJobs;
  double? rating;
  int? totalRatings;
  int? reviewCount;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? approvedAt;
  String? approvedBy;
  DateTime? rejectedAt;
  String? rejectedBy;
  String? rejectionReason;
  double? cashCollected;

  HandymanModel({
    this.id,
    this.fullName,
    this.name,
    this.email,
    this.profileImage,
    this.photoUrl,
    this.idProofUrl,
    this.phoneNumber,
    this.phone,
    this.providerId,
    this.providerName,
    this.serviceArea,
    this.skills,
    this.onboardingStatus,
    this.isApproved,
    this.isActive,
    this.commissionRate,
    this.walletBalance,
    this.totalEarnings,
    this.totalJobs,
    this.completedJobs,
    this.rating,
    this.totalRatings,
    this.reviewCount,
    this.createdAt,
    this.updatedAt,
    this.approvedAt,
    this.approvedBy,
    this.rejectedAt,
    this.rejectedBy,
    this.rejectionReason,
    this.cashCollected,
  });

  HandymanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? json['uid'];
    name = json['name'];
    fullName = json['fullName'] ?? json['name'];
    email = json['email'];
    profileImage = json['profileImage'];
    photoUrl = json['photoUrl'];
    idProofUrl = json['idProofUrl'];
    phoneNumber = json['phoneNumber'];
    phone = json['phone'];
    providerId = json['providerId'];
    providerName = json['providerName'];
    serviceArea = json['serviceArea'];
    skills = json['skills'] != null ? List<String>.from(json['skills']) : null;
    onboardingStatus = json['onboardingStatus'];
    isApproved = json['isApproved'];
    isActive = json['isActive'];
    commissionRate = json['commissionRate'];
    walletBalance = json['walletBalance']?.toDouble();
    totalEarnings = json['totalEarnings']?.toDouble();
    totalJobs = json['totalJobs'] ?? json['completedJobs'];
    completedJobs = json['completedJobs'];
    rating = json['rating']?.toDouble();
    totalRatings = json['totalRatings'] ?? json['reviewCount'];
    reviewCount = json['reviewCount'];
    createdAt = _dateTimeFromTimestamp(json['createdAt']);
    updatedAt = _dateTimeFromTimestamp(json['updatedAt']);
    approvedAt = _dateTimeFromTimestamp(json['approvedAt']);
    approvedBy = json['approvedBy'];
    rejectedAt = _dateTimeFromTimestamp(json['rejectedAt']);
    rejectedBy = json['rejectedBy'];
    rejectionReason = json['rejectionReason'];
    cashCollected = json['cashCollected']?.toDouble();
  }

  DateTime? _dateTimeFromTimestamp(dynamic timestamp) {
    if (timestamp is Timestamp) return timestamp.toDate();
    if (timestamp is int) return DateTime.fromMillisecondsSinceEpoch(timestamp);
    return null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['fullName'] = fullName;
    data['email'] = email;
    data['profileImage'] = profileImage;
    data['photoUrl'] = photoUrl;
    data['idProofUrl'] = idProofUrl;
    data['phoneNumber'] = phoneNumber;
    data['phone'] = phone;
    data['providerId'] = providerId;
    data['providerName'] = providerName;
    data['serviceArea'] = serviceArea;
    if (skills != null) data['skills'] = skills;
    data['onboardingStatus'] = onboardingStatus;
    data['isApproved'] = isApproved;
    data['isActive'] = isActive;
    data['commissionRate'] = commissionRate;
    data['walletBalance'] = walletBalance;
    data['totalEarnings'] = totalEarnings;
    data['totalJobs'] = totalJobs;
    data['completedJobs'] = completedJobs;
    data['rating'] = rating;
    data['totalRatings'] = totalRatings;
    data['reviewCount'] = reviewCount;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['approvedAt'] = approvedAt;
    data['approvedBy'] = approvedBy;
    data['rejectedAt'] = rejectedAt;
    data['rejectedBy'] = rejectedBy;
    data['rejectionReason'] = rejectionReason;
    data['cashCollected'] = cashCollected;
    return data;
  }
}

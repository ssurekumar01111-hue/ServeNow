import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handyman/features/profile/domain/entities/handyman_profile_entity.dart';

class HandymanModel {
  final String uid;
  final String name;
  final String phone;
  final String photoUrl;
  final String idProofUrl;
  final String serviceArea;
  final List<String> skills;
  final String onboardingStatus;
  final bool isApproved;
  final bool isActive;
  final int commissionRate;
  final double walletBalance;
  final double totalEarnings;
  final int completedJobs;
  final int assignedJobs;
  final double rating;
  final int reviewCount;
  final String fcmToken;
  final String providerId;
  final Timestamp? approvedAt;
  final Timestamp? rejectedAt;
  final String rejectionReason;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  HandymanModel({
    required this.uid,
    required this.name,
    required this.phone,
    required this.photoUrl,
    required this.idProofUrl,
    required this.serviceArea,
    required this.skills,
    this.onboardingStatus = 'pending',
    this.isApproved = false,
    this.isActive = false,
    this.commissionRate = 0,
    this.walletBalance = 0.0,
    this.totalEarnings = 0.0,
    this.completedJobs = 0,
    this.assignedJobs = 0,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.fcmToken = '',
    this.providerId = '',
    this.approvedAt,
    this.rejectedAt,
    this.rejectionReason = '',
    this.createdAt,
    this.updatedAt,
  });

  factory HandymanModel.fromJson(Map<String, dynamic> json) {
    return HandymanModel(
      uid:              _str(json['uid']),
      name:             _str(json['name']),
      phone:            _str(json['phone']),
      photoUrl:         _str(json['photoUrl']),
      idProofUrl:       _str(json['idProofUrl']),
      serviceArea:      _str(json['serviceArea']),
      skills:           _strList(json['skills']),
      onboardingStatus: _str(json['onboardingStatus'], 'pending'),
      isApproved:       _bool(json['isApproved']),
      isActive:         _bool(json['isActive']),
      commissionRate:   _int(json['commissionRate']),
      walletBalance:    _dbl(json['walletBalance']),
      totalEarnings:    _dbl(json['totalEarnings']),
      completedJobs:    _int(json['completedJobs']),
      assignedJobs:     _int(json['assignedJobs']),
      rating:           _dbl(json['rating']),
      reviewCount:      _int(json['reviewCount']),
      fcmToken:         _str(json['fcmToken']),
      providerId:       _str(json['providerId']),
      approvedAt:       json['approvedAt'] as Timestamp?,
      rejectedAt:       json['rejectedAt'] as Timestamp?,
      rejectionReason:  _str(json['rejectionReason']),
      createdAt:        json['createdAt'] as Timestamp?,
      updatedAt:        json['updatedAt'] as Timestamp?,
    );
  }

  static String _str(dynamic v, [String d = '']) =>
      v == null ? d : v.toString();

  static double _dbl(dynamic v, [double d = 0.0]) =>
      v == null ? d : (v is num ? v.toDouble() : double.tryParse(v.toString()) ?? d);

  static int _int(dynamic v, [int d = 0]) =>
      v == null ? d : (v is num ? v.toInt() : int.tryParse(v.toString()) ?? d);

  static bool _bool(dynamic v, [bool d = false]) =>
      v == null ? d : (v is bool ? v : v.toString() == 'true');

  static List<String> _strList(dynamic v) =>
      v == null ? [] : (v as List).map((e) => e.toString()).toList();

  HandymanProfileEntity toEntity() {
    return HandymanProfileEntity(
      id: uid,
      name: name,
      phone: phone,
      skills: skills,
      serviceArea: serviceArea,
      photoUrl: photoUrl,
      email: '', // Not in model but in entity
      rating: rating,
      totalRatings: reviewCount,
      commissionRate: commissionRate,
      walletBalance: walletBalance,
      totalEarnings: totalEarnings,
      cashCollected: 0.0, // Not in model but in entity
      isOnline: isActive,
      isApproved: isApproved,
      onboardingStatus: onboardingStatus,
      providerId: providerId,
    );
  }
}

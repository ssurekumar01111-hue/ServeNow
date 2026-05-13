import 'package:cloud_firestore/cloud_firestore.dart';

class ProviderModel {
  final String id;
  final String uid;
  final String businessName;
  final String phone;
  final String email;
  final String photoUrl;
  final String description;
  final String onboardingStatus;
  final bool isActive;
  final double commissionRate;
  final double rating;
  final int totalRatings;
  final int totalBookings;
  final double totalEarnings;
  final List<String> categories;
  final String serviceArea;
  final String idProofUrl;
  final String businessLicenseUrl;
  final String fcmToken;
  final String rejectionReason;
  final String bankAccountNumber;
  final String bankIFSC;
  final String bankAccountName;
  final String gstNumber;
  final Timestamp? createdAt;
  final Timestamp? approvedAt;

  ProviderModel({
    this.id = '',
    this.uid = '',
    this.businessName = '',
    this.phone = '',
    this.email = '',
    this.photoUrl = '',
    this.description = '',
    this.onboardingStatus = 'pending_profile',
    this.isActive = false,
    this.commissionRate = 10.0,
    this.rating = 0.0,
    this.totalRatings = 0,
    this.totalBookings = 0,
    this.totalEarnings = 0.0,
    this.categories = const [],
    this.serviceArea = '',
    this.idProofUrl = '',
    this.businessLicenseUrl = '',
    this.fcmToken = '',
    this.rejectionReason = '',
    this.bankAccountNumber = '',
    this.bankIFSC = '',
    this.bankAccountName = '',
    this.gstNumber = '',
    this.createdAt,
    this.approvedAt,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    try {
      return ProviderModel(
        id: _str(json['uid'] ?? json['id']),
        uid: _str(json['uid'] ?? json['id']),
        businessName: _str(json['businessName']),
        phone: _str(json['phone']),
        email: _str(json['email']),
        photoUrl: _str(json['photoUrl'] ?? json['logoUrl'] ?? json['profileImage']),
        description: _str(json['description']),
        onboardingStatus: _str(json['onboardingStatus'], fallback: 'pending_profile'),
        isActive: json['isActive'] as bool? ?? false,
        commissionRate: _dbl(json['commissionRate'], fallback: 10.0),
        rating: _dbl(json['rating']),
        totalRatings: _int(json['reviewCount'] ?? json['totalRatings']),
        totalBookings: _int(json['completedJobs'] ?? json['totalBookings']),
        totalEarnings: _dbl(json['totalEarnings']),
        categories: json['categories'] != null
            ? List<String>.from(json['categories'] as List)
            : json['serviceCategories'] != null
                ? List<String>.from(json['serviceCategories'] as List)
                : [],
        serviceArea: _str(json['serviceArea'] ??
            (json['serviceAreas'] is List
                ? (json['serviceAreas'] as List).join(', ')
                : json['serviceAreas'])),
        idProofUrl: _str(json['idProofUrl']),
        businessLicenseUrl: _str(json['businessLicenseUrl']),
        fcmToken: _str(json['fcmToken']),
        rejectionReason: _str(json['rejectionReason']),
        bankAccountNumber: _str(json['bankAccountNumber']),
        bankIFSC: _str(json['bankIFSC']),
        bankAccountName: _str(json['bankAccountName']),
        gstNumber: _str(json['gstNumber']),
        createdAt: json['createdAt'] is Timestamp ? json['createdAt'] as Timestamp : null,
        approvedAt: json['approvedAt'] is Timestamp ? json['approvedAt'] as Timestamp : null,
      );
    } catch (e, stack) {
      print('ProviderModel.fromJson error: $e');
      print('Stack: $stack');
      print('JSON was: $json');
      // Return empty model instead of crashing
      return ProviderModel(
        id: _str(json['uid'] ?? json['id']),
        uid: _str(json['uid'] ?? json['id']),
        businessName: _str(json['businessName'], fallback: 'Unknown Provider'),
        onboardingStatus: _str(json['onboardingStatus'], fallback: 'pending_profile'),
      );
    }
  }

  // Safe string parser
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

  // Safe int parser
  static int _int(dynamic v, {int fallback = 0}) {
    if (v == null) return fallback;
    if (v is int) return v;
    if (v is double) return v.toInt();
    if (v is String) return int.tryParse(v) ?? fallback;
    return fallback;
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'businessName': businessName,
        'phone': phone,
        'email': email,
        'photoUrl': photoUrl,
        'description': description,
        'onboardingStatus': onboardingStatus,
        'isActive': isActive,
        'commissionRate': commissionRate,
        'rating': rating,
        'reviewCount': totalRatings,
        'completedJobs': totalBookings,
        'totalEarnings': totalEarnings,
        'categories': categories,
        'serviceArea': serviceArea,
        'idProofUrl': idProofUrl,
        'businessLicenseUrl': businessLicenseUrl,
        'fcmToken': fcmToken,
        'rejectionReason': rejectionReason,
        'createdAt': createdAt,
        'approvedAt': approvedAt,
      };
}

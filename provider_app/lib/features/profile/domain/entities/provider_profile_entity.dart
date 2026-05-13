import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'provider_profile_entity.freezed.dart';

@freezed
abstract class ProviderProfileEntity with _$ProviderProfileEntity {
  const factory ProviderProfileEntity({
    required String id,
    required String uid,
    required String email,
    required String phone,
    required String businessName,
    String? logoUrl,
    required List<String> categories,
    required String serviceArea,
    String? idProofUrl,
    String? idProofType,
    String? bankAccountNumber,
    String? bankIFSC,
    String? bankAccountName,
    String? gstNumber,
    required double commissionRate,
    required String onboardingStatus, // 'pending_profile' | 'pending_approval' | 'approved' | 'rejected'
    String? rejectionReason,
    required bool isActive,
    required double rating,
    required int totalRatings,
    required int totalBookings,
    required double totalEarnings,
    @Default(0.0) double walletBalance,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? approvedAt,
    String? approvedBy,
    String? description,
    String? businessLicenseUrl,
  }) = _ProviderProfileEntity;

  const ProviderProfileEntity._();

  static double _dbl(dynamic v, [double d = 0.0]) =>
      v == null ? d : (v is num ? v.toDouble() : double.tryParse(v.toString()) ?? d);

  static int _int(dynamic v, [int d = 0]) =>
      v == null ? d : (v is num ? v.toInt() : int.tryParse(v.toString()) ?? d);

  factory ProviderProfileEntity.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProviderProfileEntity(
      id: doc.id,
      uid: (data['uid'] as String?) ?? (data['id'] as String?) ?? doc.id,
      email: (data['email'] as String?) ?? '',
      phone: (data['phone'] as String?) ?? '',
      businessName: (data['businessName'] as String?) ?? 'Unknown Business',
      logoUrl: (data['photoUrl'] as String?) ?? (data['logoUrl'] as String?),
      categories: List<String>.from(data['categories'] as Iterable<dynamic>? ?? data['serviceCategories'] as Iterable<dynamic>? ?? []),
      serviceArea: (data['serviceArea'] as String?) ?? (data['serviceAreas'] is List && (data['serviceAreas'] as List).isNotEmpty ? (data['serviceAreas'] as List)[0].toString() : ''),
      idProofUrl: (data['idProofUrl'] as String?) ?? (data['businessLicenseUrl'] as String?),
      idProofType: data['idProofType'] as String?,
      bankAccountNumber: data['bankAccountNumber'] as String?,
      bankIFSC: data['bankIFSC'] as String?,
      bankAccountName: data['bankAccountName'] as String?,
      gstNumber: data['gstNumber'] as String?,
      commissionRate: _dbl(data['commissionRate'], 10.0),
      onboardingStatus: (data['onboardingStatus'] as String?) ?? 'pending_profile',
      rejectionReason: data['rejectionReason'] as String?,
      isActive: (data['isActive'] as bool?) ?? false,
      rating: _dbl(data['rating']),
      totalRatings: _int(data['reviewCount'] ?? data['totalRatings']),
      totalBookings: _int(data['completedJobs'] ?? data['totalBookings']),
      totalEarnings: _dbl(data['totalEarnings']),
      walletBalance: _dbl(data['walletBalance']),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      approvedAt: (data['approvedAt'] as Timestamp?)?.toDate(),
      approvedBy: data['approvedBy'] as String?,
      description: data['description'] as String?,
      businessLicenseUrl: data['businessLicenseUrl'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'email': email,
      'phone': phone,
      'businessName': businessName,
      'photoUrl': logoUrl,
      'logoUrl': logoUrl,
      'categories': categories,
      'serviceArea': serviceArea,
      'serviceAreas': [serviceArea],
      'idProofUrl': idProofUrl,
      'idProofType': idProofType,
      'bankAccountNumber': bankAccountNumber,
      'bankIFSC': bankIFSC,
      'bankAccountName': bankAccountName,
      'gstNumber': gstNumber,
      'commissionRate': commissionRate,
      'onboardingStatus': onboardingStatus,
      'rejectionReason': rejectionReason,
      'isActive': isActive,
      'rating': rating,
      'reviewCount': totalRatings,
      'totalRatings': totalRatings,
      'completedJobs': totalBookings,
      'totalBookings': totalBookings,
      'totalEarnings': totalEarnings,
      'walletBalance': walletBalance,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'approvedAt': approvedAt != null ? Timestamp.fromDate(approvedAt!) : null,
      'approvedBy': approvedBy,
      'description': description,
      'businessLicenseUrl': businessLicenseUrl,
    };
  }
}

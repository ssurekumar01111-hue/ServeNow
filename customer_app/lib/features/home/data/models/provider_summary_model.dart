import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/features/home/domain/entities/provider_summary_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'provider_summary_model.freezed.dart';
part 'provider_summary_model.g.dart';

@freezed
abstract class ProviderSummaryModel with _$ProviderSummaryModel {
  const factory ProviderSummaryModel({
    required String id,
    required String businessName,
    required double rating,
    required int reviewCount,
    required String photoUrl,
    required List<String> categories,
    @Default(false) bool isVerified,
    double? distance,
    @Default(0) int completedJobs,
    String? serviceArea,
    @Default(true) bool isActive,
    String? onboardingStatus,
  }) = _ProviderSummaryModel;

  const ProviderSummaryModel._();

  factory ProviderSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$ProviderSummaryModelFromJson(json);

  factory ProviderSummaryModel.fromFirestore(DocumentSnapshot doc, [double? dist]) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return ProviderSummaryModel.fromJson({
      'id': doc.id,
      'businessName': (data['businessName'] as String?) ?? 'Provider',
      'rating': ((data['rating'] as num?) ?? 0.0).toDouble(),
      'reviewCount': (data['reviewCount'] as int?) ?? 0,
      'photoUrl': (data['photoUrl'] as String?) ?? '',
      'categories': List<String>.from(data['categories'] as Iterable? ?? []),
      'isVerified': (data['isVerified'] as bool?) ?? false,
      'distance': dist,
      'completedJobs': (data['completedJobs'] as int?) ?? 0,
      'serviceArea': (data['serviceArea'] as String?) ?? '',
      'isActive': (data['isActive'] as bool?) ?? true,
      'onboardingStatus': (data['onboardingStatus'] as String?) ?? 'approved',
    });
  }

  ProviderSummaryEntity toEntity() => ProviderSummaryEntity(
        id: id,
        businessName: businessName,
        rating: rating,
        reviewCount: reviewCount,
        photoUrl: photoUrl,
        categories: categories,
        isVerified: isVerified,
        distance: distance,
        completedJobs: completedJobs,
        serviceArea: serviceArea,
        isActive: isActive,
        onboardingStatus: onboardingStatus,
      );
}

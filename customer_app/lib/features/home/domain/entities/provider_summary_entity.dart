import 'package:freezed_annotation/freezed_annotation.dart';

part 'provider_summary_entity.freezed.dart';

@freezed
abstract class ProviderSummaryEntity with _$ProviderSummaryEntity {
  const factory ProviderSummaryEntity({
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
  }) = _ProviderSummaryEntity;

  const ProviderSummaryEntity._();
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'handyman_profile_entity.freezed.dart';

@freezed
abstract class HandymanProfileEntity with _$HandymanProfileEntity {
  const factory HandymanProfileEntity({
    required String id,
    @Default('') String name,
    @Default('') String phone,
    @Default([]) List<String> skills,
    @Default('') String serviceArea,
    @Default('') String photoUrl,
    @Default('') String email,
    @Default(0.0) double rating,
    @Default(0) int totalRatings,
    @Default(0) int commissionRate,
    @Default(0.0) double walletBalance,
    @Default(0.0) double totalEarnings,
    @Default(0.0) double cashCollected,
    @Default(false) bool isOnline,
    @Default(false) bool isApproved,
    @Default('') String onboardingStatus,
    @Default('') String providerId,
  }) = _HandymanProfileEntity;

  const HandymanProfileEntity._();
}

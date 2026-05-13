import 'package:customer/features/services/domain/entities/service_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'provider_detail_entity.freezed.dart';

@freezed
abstract class ProviderDetailEntity with _$ProviderDetailEntity {
  const factory ProviderDetailEntity({
    required String id,
    required String businessName,
    required String photoUrl,
    required double rating,
    required int reviewCount,
    required String description, required Map<String, dynamic> workingHours, required List<String> serviceArea, @Default(false) bool isVerified,
    @Default([]) List<ServiceEntity> services,
    @Default([]) List<String> gallery,
    String? coverPhoto,
  }) = _ProviderDetailEntity;

  const ProviderDetailEntity._();
}

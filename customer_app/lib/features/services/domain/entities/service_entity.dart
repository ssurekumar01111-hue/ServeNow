import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_entity.freezed.dart';

@freezed
abstract class ServiceEntity with _$ServiceEntity {
  const factory ServiceEntity({
    required String id,
    required String name,
    required String description,
    required String categoryId,
    required String providerId,
    required double basePrice,
    required int duration,
    double? discountPrice,
    @Default([]) List<String> images,
    @Default(0.0) double rating,
    @Default(0) int reviewCount,
    @Default(true) bool isActive,
    @Default(0) int bookingCount,
    String? categoryName,
    String? imageUrl,
    String? providerName,
  }) = _ServiceEntity;

  const ServiceEntity._();
}

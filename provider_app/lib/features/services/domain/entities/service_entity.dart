import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_entity.freezed.dart';

@freezed
abstract class ServiceEntity with _$ServiceEntity {
  const factory ServiceEntity({
    required String id,
    required String name,
    required String categoryId,
    required String description,
    required double basePrice,
    required bool isActive, required Map<String, dynamic> workingHours, required int estimatedDuration, @Default([]) List<ServicePackage> packages,
    @Default([]) List<String> images,
  }) = _ServiceEntity;

  const ServiceEntity._();
}

@freezed
abstract class ServicePackage with _$ServicePackage {
  const factory ServicePackage({
    required String name,
    required String description,
    required double price,
    required int duration,
  }) = _ServicePackage;

  const ServicePackage._();
}

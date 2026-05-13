import 'package:freezed_annotation/freezed_annotation.dart';

part 'banner_entity.freezed.dart';

@freezed
abstract class BannerEntity with _$BannerEntity {
  const factory BannerEntity({
    required String id,
    required String title,
    required String subtitle,
    required String imageUrl,
    required String actionType,
    required String actionValue,
    required int sortOrder,
    @Default(true) bool isActive,
    String? targetRoute, // for compatibility
  }) = _BannerEntity;

  const BannerEntity._();
}

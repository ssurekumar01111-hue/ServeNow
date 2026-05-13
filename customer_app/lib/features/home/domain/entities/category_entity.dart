import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_entity.freezed.dart';

@freezed
abstract class CategoryEntity with _$CategoryEntity {
  const factory CategoryEntity({
    required String id,
    required String name,
    required String iconUrl,
    required int sortOrder,
    @Default(true) bool isActive,
    String? iconName, // Keep for backward compatibility
    String? color,    // Keep for backward compatibility
  }) = _CategoryEntity;

  const CategoryEntity._();
}

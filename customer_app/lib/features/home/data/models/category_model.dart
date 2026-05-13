import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/features/home/domain/entities/category_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
abstract class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required String id,
    required String name,
    required String iconUrl,
    required int sortOrder,
    @Default(true) bool isActive,
    String? iconName,
    String? color,
  }) = _CategoryModel;

  const CategoryModel._();

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  factory CategoryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final icon = (data['icon'] as String?) ?? (data['iconName'] as String?) ?? 'home';
    return CategoryModel.fromJson({
      'id': doc.id,
      'name': (data['name'] as String?) ?? '',
      'iconUrl': (data['iconUrl'] as String?) ?? (icon.startsWith('http') ? icon : ''),
      'sortOrder': (data['sortOrder'] as int?) ?? 0,
      'isActive': (data['isActive'] as bool?) ?? true,
      'iconName': icon,
      'color': (data['color'] as String?) ?? '#000000',
    });
  }

  CategoryEntity toEntity() => CategoryEntity(
        id: id,
        name: name,
        iconUrl: iconUrl,
        sortOrder: sortOrder,
        isActive: isActive,
        iconName: iconName,
        color: color,
      );
}

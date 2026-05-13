import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? id;
  String? name;
  String? iconName;
  String? color;
  bool? isActive;
  int? sortOrder;
  Timestamp? createdAt;

  CategoryModel({
    this.id,
    this.name,
    this.iconName,
    this.color,
    this.isActive,
    this.sortOrder,
    this.createdAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Unknown',
      iconName: json['iconName']?.toString() ?? 'home',
      color: json['color']?.toString() ?? '#000000',
      isActive: json['isActive'] as bool? ?? true,
      sortOrder: json['sortOrder'] as int? ?? json['order'] as int? ?? 0,
      createdAt: json['createdAt'] is Timestamp ? json['createdAt'] as Timestamp : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['iconName'] = iconName;
    data['color'] = color;
    data['isActive'] = isActive;
    data['sortOrder'] = sortOrder;
    data['createdAt'] = createdAt;
    return data;
  }
}

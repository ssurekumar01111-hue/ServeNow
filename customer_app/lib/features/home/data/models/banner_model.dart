import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/features/home/domain/entities/banner_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'banner_model.freezed.dart';
part 'banner_model.g.dart';

@freezed
abstract class BannerModel with _$BannerModel {
  const factory BannerModel({
    required String id,
    required String title,
    required String subtitle,
    required String imageUrl,
    required String actionType,
    required String actionValue,
    required int sortOrder,
    @Default(true) bool isActive,
    String? targetRoute,
  }) = _BannerModel;

  const BannerModel._();

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);

  factory BannerModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BannerModel.fromJson({
      'id': doc.id,
      'title': (data['title'] as String?) ?? '',
      'subtitle': (data['subtitle'] as String?) ?? '',
      'imageUrl': (data['imageUrl'] as String?) ?? '',
      'actionType': (data['actionType'] as String?) ?? 'none',
      'actionValue': (data['actionValue'] as String?) ?? '',
      'sortOrder': (data['sortOrder'] as int?) ?? 0,
      'isActive': (data['isActive'] as bool?) ?? true,
      'targetRoute': (data['targetRoute'] as String?) ?? '/home',
    });
  }

  BannerEntity toEntity() => BannerEntity(
        id: id,
        title: title,
        subtitle: subtitle,
        imageUrl: imageUrl,
        actionType: actionType,
        actionValue: actionValue,
        sortOrder: sortOrder,
        isActive: isActive,
        targetRoute: targetRoute,
      );
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/features/services/data/models/service_model.dart';
import 'package:customer/features/services/domain/entities/provider_detail_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'provider_detail_model.freezed.dart';
part 'provider_detail_model.g.dart';

@freezed
abstract class ProviderDetailModel with _$ProviderDetailModel {
  const factory ProviderDetailModel({
    required String id,
    required String businessName,
    required String photoUrl,
    required double rating,
    required int reviewCount,
    required String description, required Map<String, dynamic> workingHours, required List<String> serviceArea, @Default(false) bool isVerified,
    @Default([]) List<ServiceModel> services,
    @Default([]) List<String> gallery,
    String? coverPhoto,
  }) = _ProviderDetailModel;

  const ProviderDetailModel._();

  factory ProviderDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ProviderDetailModelFromJson(json);

  factory ProviderDetailModel.fromFirestore(DocumentSnapshot doc, List<ServiceModel> services) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return ProviderDetailModel.fromJson({
      'id': doc.id,
      'businessName': (data['businessName'] as String?) ?? 'Provider',
      'photoUrl': (data['photoUrl'] as String?) ?? '',
      'rating': ((data['rating'] as num?) ?? 0.0).toDouble(),
      'reviewCount': (data['reviewCount'] as int?) ?? 0,
      'description': (data['description'] as String?) ?? '',
      'workingHours': data['workingHours'] as Map<String, dynamic>? ?? {},
      'serviceArea': data['serviceArea'] is String 
          ? [data['serviceArea'] as String] 
          : List<String>.from(data['serviceArea'] as Iterable? ?? []),
      'isVerified': (data['isVerified'] as bool?) ?? false,
      'gallery': List<String>.from(data['gallery'] as Iterable? ?? []),
      'coverPhoto': data['coverPhoto'] as String?,
      'services': services.map((e) => e.toJson()).toList(),
    });
  }

  ProviderDetailEntity toEntity() => ProviderDetailEntity(
        id: id,
        businessName: businessName,
        photoUrl: photoUrl,
        rating: rating,
        reviewCount: reviewCount,
        isVerified: isVerified,
        description: description,
        services: services.map((e) => e.toEntity()).toList(),
        gallery: gallery,
        workingHours: workingHours,
        serviceArea: serviceArea,
        coverPhoto: coverPhoto,
      );
}

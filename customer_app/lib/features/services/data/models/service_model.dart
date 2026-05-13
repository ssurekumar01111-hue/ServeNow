import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/features/services/domain/entities/service_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_model.freezed.dart';
part 'service_model.g.dart';

@freezed
abstract class ServiceModel with _$ServiceModel {
  const factory ServiceModel({
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
  }) = _ServiceModel;

  const ServiceModel._();

  static int _int(dynamic v, [int d = 0]) =>
      v == null ? d : (v is num ? v.toInt() : int.tryParse(v.toString()) ?? d);

  static double _dbl(dynamic v, [double d = 0.0]) =>
      v == null ? d : (v is num ? v.toDouble() : double.tryParse(v.toString()) ?? d);

  static String _str(dynamic v, [String d = '']) =>
      v == null ? d : v.toString();

  static bool _bool(dynamic v, [bool d = false]) =>
      v == null ? d : (v is bool ? v : v.toString() == 'true');

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);

  factory ServiceModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    final rawImages = data['images'] ?? (data['imageUrl'] != null ? [data['imageUrl']] : []);
    final imagesList = List<String>.from(
      (rawImages as Iterable? ?? []).map((e) => e.toString()),
    );
    
    return ServiceModel(
      id: doc.id,
      name: _str(data['name']),
      description: _str(data['description']),
      categoryId: _str(data['categoryId']),
      providerId: _str(data['providerId']),
      basePrice: _dbl(data['price'] ?? data['basePrice']),
      duration: _int(data['duration']),
      discountPrice: data['discountPrice'] != null ? _dbl(data['discountPrice']) : null,
      images: imagesList,
      rating: _dbl(data['rating']),
      reviewCount: _int(data['reviewCount']),
      isActive: _bool(data['isActive'], true),
      bookingCount: _int(data['bookingCount']),
      categoryName: _str(data['categoryName']),
      imageUrl: _str(data['imageUrl'] ?? (imagesList.isNotEmpty ? imagesList.first : '')),
      providerName: _str(data['providerName'] ?? data['categoryName']),
    );
  }

  ServiceEntity toEntity() => ServiceEntity(
        id: id,
        name: name,
        description: description,
        categoryId: categoryId,
        providerId: providerId,
        basePrice: basePrice,
        discountPrice: discountPrice,
        duration: duration,
        images: images,
        rating: rating,
        reviewCount: reviewCount,
        isActive: isActive,
        bookingCount: bookingCount,
        categoryName: categoryName,
        imageUrl: imageUrl,
        providerName: providerName,
      );
}

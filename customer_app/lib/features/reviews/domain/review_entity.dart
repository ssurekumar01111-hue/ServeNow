import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_entity.freezed.dart';
part 'review_entity.g.dart';

@freezed
abstract class ReviewEntity with _$ReviewEntity {
  const factory ReviewEntity({
    required String id,
    required String bookingId,
    required String customerId,
    required String customerName,
    required String providerId,
    String? handymanId,
    required double providerRating,
    required double handymanRating,
    String? comment,
    @Default([]) List<String> photos,
    @Default(true) bool isVisible,
    required DateTime createdAt,
  }) = _ReviewEntity;

  const ReviewEntity._();

  factory ReviewEntity.fromJson(Map<String, dynamic> json) =>
      _$ReviewEntityFromJson(json);
}

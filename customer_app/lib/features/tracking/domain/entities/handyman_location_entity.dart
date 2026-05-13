import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'handyman_location_entity.freezed.dart';

@freezed
abstract class HandymanLocationEntity with _$HandymanLocationEntity {
  const factory HandymanLocationEntity({
    required double latitude,
    required double longitude,
    required DateTime updatedAt,
    required String bookingId,
  }) = _HandymanLocationEntity;

  const HandymanLocationEntity._();
}

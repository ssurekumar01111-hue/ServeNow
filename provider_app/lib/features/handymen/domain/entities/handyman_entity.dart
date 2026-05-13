import 'package:freezed_annotation/freezed_annotation.dart';

part 'handyman_entity.freezed.dart';

@freezed
abstract class HandymanEntity with _$HandymanEntity {
  const factory HandymanEntity({
    required String id,
    required String providerId,
    required String name,
    required String phone,
    required List<String> skills,
    required String photoUrl,
    required String idProofUrl,
    @Default(0) int commissionRate,
    @Default(false) bool isOnline,
    @Default(true) bool isAvailable,
  }) = _HandymanEntity;

  const HandymanEntity._();
}

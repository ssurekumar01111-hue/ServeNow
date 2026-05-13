import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_entity.freezed.dart';
part 'wallet_entity.g.dart';

@freezed
abstract class WalletEntity with _$WalletEntity {
  const factory WalletEntity({
    required String id,
    required String userId,
    required double balance,
    required String currency,
  }) = _WalletEntity;

  const WalletEntity._();

  factory WalletEntity.fromJson(Map<String, dynamic> json) =>
      _$WalletEntityFromJson(json);
}

@freezed
abstract class TransactionEntity with _$TransactionEntity {
  const factory TransactionEntity({
    required String id,
    required String type, // credit | debit
    required double amount,
    required String description,
    String? bookingId,
    required DateTime createdAt,
  }) = _TransactionEntity;

  const TransactionEntity._();

  factory TransactionEntity.fromJson(Map<String, dynamic> json) =>
      _$TransactionEntityFromJson(json);
}

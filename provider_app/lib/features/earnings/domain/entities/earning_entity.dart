import 'package:freezed_annotation/freezed_annotation.dart';

part 'earning_entity.freezed.dart';

@freezed
abstract class EarningEntity with _$EarningEntity {
  const factory EarningEntity({
    required double totalEarnings,
    required double totalWithdrawn,
    required double availableBalance,
    required List<TransactionEntity> transactions,
  }) = _EarningEntity;

  const EarningEntity._();
}

@freezed
abstract class TransactionEntity with _$TransactionEntity {
  const factory TransactionEntity({
    required String id,
    String? bookingId,
    required double amount,
    double? commission,
    double? netAmount,
    required DateTime createdAt,
    required String type, // booking | withdrawal
    @Default('completed') String status, // pending | completed | rejected
    String? rejectionReason,
    Map<String, dynamic>? bankDetails,
    DateTime? requestedAt,
  }) = _TransactionEntity;

  const TransactionEntity._();
}

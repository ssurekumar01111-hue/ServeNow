// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WalletEntity _$WalletEntityFromJson(Map<String, dynamic> json) =>
    _WalletEntity(
      id: json['id'] as String,
      userId: json['userId'] as String,
      balance: (json['balance'] as num).toDouble(),
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$WalletEntityToJson(_WalletEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'balance': instance.balance,
      'currency': instance.currency,
    };

_TransactionEntity _$TransactionEntityFromJson(Map<String, dynamic> json) =>
    _TransactionEntity(
      id: json['id'] as String,
      type: json['type'] as String,
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      bookingId: json['bookingId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$TransactionEntityToJson(_TransactionEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'amount': instance.amount,
      'description': instance.description,
      'bookingId': instance.bookingId,
      'createdAt': instance.createdAt.toIso8601String(),
    };

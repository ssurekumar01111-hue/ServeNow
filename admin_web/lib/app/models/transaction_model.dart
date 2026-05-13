import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  String? id;
  String? userId;
  String? userType; // 'customer', 'provider', 'handyman'
  double? amount;
  String? type; // 'credit' or 'debit'
  String? status;
  Timestamp? createdAt;
  String? description;

  TransactionModel({
    this.id,
    this.userId,
    this.userType,
    this.amount,
    this.type,
    this.status,
    this.createdAt,
    this.description,
  });

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    userType = json['userType'];
    amount = json['amount']?.toDouble();
    type = json['type'];
    status = json['status'];
    createdAt = json['createdAt'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['userType'] = userType;
    data['amount'] = amount;
    data['type'] = type;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['description'] = description;
    return data;
  }
}

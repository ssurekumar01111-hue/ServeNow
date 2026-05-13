import 'package:cloud_firestore/cloud_firestore.dart';

abstract class WalletRemoteDataSource {
  Future<void> requestWithdrawal(String providerId, double amount, String paymentInfo);
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  WalletRemoteDataSourceImpl(this.firestore);
  final FirebaseFirestore firestore;

  @override
  Future<void> requestWithdrawal(String providerId, double amount, String paymentInfo) async {
    await firestore.collection('withdrawals').add({
      'providerId': providerId,
      'amount': amount,
      'paymentInfo': paymentInfo,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}

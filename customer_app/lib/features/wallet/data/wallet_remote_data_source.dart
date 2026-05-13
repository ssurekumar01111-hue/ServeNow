import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/features/wallet/domain/wallet_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WalletRemoteDataSource {
  final FirebaseFirestore _firestore;

  WalletRemoteDataSource(this._firestore);

  Stream<WalletEntity> getWallet(String userId) {
    return _firestore
        .collection('wallets')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) {
        return WalletEntity(
          id: userId,
          userId: userId,
          balance: 0,
          currency: 'INR',
        );
      }
      final data = snapshot.data() as Map<String, dynamic>;
      return WalletEntity(
        id: snapshot.id,
        userId: userId,
        balance: (data['balance'] as num? ?? 0).toDouble(),
        currency: (data['currency'] as String? ?? 'INR'),
      );
    });
  }

  Stream<List<TransactionEntity>> getTransactions(String userId) {
    return _firestore
        .collection('wallets')
        .doc(userId)
        .collection('transactions')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return TransactionEntity(
          id: doc.id,
          type: (data['type'] as String? ?? 'credit'),
          amount: (data['amount'] as num? ?? 0).toDouble(),
          description: (data['description'] as String? ?? ''),
          bookingId: data['bookingId'] as String?,
          createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
        );
      }).toList();
    });
  }

  Future<void> addMoneyViaRazorpay(String userId, double amount, String razorpayPaymentId) async {
    final walletRef = _firestore.collection('wallets').doc(userId);
    final transactionRef = walletRef.collection('transactions').doc();

    await _firestore.runTransaction((transaction) async {
      final walletSnapshot = await transaction.get(walletRef);
      double currentBalance = 0;
      if (walletSnapshot.exists) {
        currentBalance = (walletSnapshot.data()?['balance'] as num? ?? 0).toDouble();
      }

      transaction.set(walletRef, {
        'userId': userId,
        'balance': currentBalance + amount,
        'currency': 'INR',
      }, SetOptions(merge: true));

      transaction.set(transactionRef, {
        'type': 'credit',
        'amount': amount,
        'description': 'Added via Razorpay ($razorpayPaymentId)',
        'createdAt': FieldValue.serverTimestamp(),
      });
    });
  }

  Future<void> deductFromWallet(String userId, double amount, String bookingId) async {
    final walletRef = _firestore.collection('wallets').doc(userId);
    final transactionRef = walletRef.collection('transactions').doc();

    await _firestore.runTransaction((transaction) async {
      final walletSnapshot = await transaction.get(walletRef);
      if (!walletSnapshot.exists) throw Exception('Wallet not found');
      
      double currentBalance = (walletSnapshot.data()?['balance'] as num? ?? 0).toDouble();
      if (currentBalance < amount) throw Exception('Insufficient balance');

      transaction.update(walletRef, {
        'balance': currentBalance - amount,
      });

      transaction.set(transactionRef, {
        'type': 'debit',
        'amount': amount,
        'description': 'Payment for booking #$bookingId',
        'bookingId': bookingId,
        'createdAt': FieldValue.serverTimestamp(),
      });
    });
  }
}

final walletDataSourceProvider = Provider((ref) {
  return WalletRemoteDataSource(FirebaseFirestore.instance);
});

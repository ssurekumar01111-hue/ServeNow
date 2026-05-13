import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/core/constants/booking_status.dart';
import 'package:handyman/core/providers/firebase_providers.dart';

final walletRepositoryProvider = Provider<WalletRepository>((ref) {
  return WalletRepository(ref.watch(firestoreProvider));
});

class WalletRepository {
  WalletRepository(this._firestore);
  final FirebaseFirestore _firestore;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getWalletStream(String handymanId) {
    return _firestore.collection('wallets').doc(handymanId).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getTransactions(String handymanId) {
    return _firestore
        .collection('transactions')
        .where('userId', isEqualTo: handymanId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> creditEarning({
    required String handymanId,
    required String bookingId,
    required double amount,
    required double cashCollected,
  }) async {
    final walletRef = _firestore.collection('wallets').doc(handymanId);
    final transactionRef = _firestore.collection('transactions').doc();

    await _firestore.runTransaction((transaction) async {
      final walletDoc = await transaction.get(walletRef);
      
      double currentBalance = 0;
      double currentTotalEarned = 0;
      double currentCashCollected = 0;

      if (walletDoc.exists) {
        final data = walletDoc.data()!;
        currentBalance = (data['balance'] as num? ?? 0).toDouble();
        currentTotalEarned = (data['totalEarned'] as num? ?? 0).toDouble();
        currentCashCollected = (data['cashCollected'] as num? ?? 0).toDouble();
      }

      transaction.set(walletRef, {
        'balance': currentBalance + amount,
        'totalEarned': currentTotalEarned + amount,
        'cashCollected': currentCashCollected + cashCollected,
      }, SetOptions(merge: true));

      transaction.set(transactionRef, {
        'userId': handymanId,
        'type': cashCollected > 0 ? 'cash' : 'earning',
        'amount': amount,
        'bookingId': bookingId,
        'status': BookingStatuses.completed,
        'createdAt': FieldValue.serverTimestamp(),
      });
    });
  }

  Future<void> requestWithdrawal({
    required String handymanId,
    required double amount,
    required String bankDetails,
  }) async {
    final walletRef = _firestore.collection('wallets').doc(handymanId);
    final transactionRef = _firestore.collection('transactions').doc();

    await _firestore.runTransaction((transaction) async {
      final walletDoc = await transaction.get(walletRef);
      if (!walletDoc.exists) throw Exception('Wallet not found.');

      final data = walletDoc.data()!;
      final currentBalance = (data['balance'] as num? ?? 0).toDouble();
      final currentTotalWithdrawn = (data['totalWithdrawn'] as num? ?? 0).toDouble();

      if (currentBalance < amount) throw Exception('Insufficient balance');

      transaction.set(walletRef, {
        'balance': currentBalance - amount,
        'totalWithdrawn': currentTotalWithdrawn + amount,
      }, SetOptions(merge: true));

      transaction.set(transactionRef, {
        'userId': handymanId,
        'type': 'withdrawal',
        'amount': -amount,
        'status': BookingStatuses.pending,
        'bankDetails': {'details': bankDetails},
        'createdAt': FieldValue.serverTimestamp(),
      });
    });
  }

  Future<void> topUpWallet({
    required String handymanId,
    required double amount,
    String? razorpayPaymentId,
  }) async {
    final walletRef = _firestore.collection('wallets').doc(handymanId);
    final transactionRef = _firestore.collection('transactions').doc();

    await _firestore.runTransaction((transaction) async {
      final walletDoc = await transaction.get(walletRef);
      double currentBalance = 0;

      if (walletDoc.exists) {
        currentBalance = (walletDoc.data()!['balance'] as num? ?? 0).toDouble();
      }

      transaction.set(walletRef, {
        'balance': currentBalance + amount,
      }, SetOptions(merge: true));

      transaction.set(transactionRef, {
        'userId': handymanId,
        'type': 'topup',
        'amount': amount,
        'razorpayPaymentId': razorpayPaymentId,
        'status': BookingStatuses.completed,
        'createdAt': FieldValue.serverTimestamp(),
      });
    });
  }
}

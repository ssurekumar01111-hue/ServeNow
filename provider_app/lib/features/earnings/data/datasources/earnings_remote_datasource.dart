import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/features/earnings/domain/entities/earning_entity.dart';
import 'package:rxdart/rxdart.dart';

abstract class EarningsRemoteDataSource {
  Stream<EarningEntity> getEarningsStream(String providerId);
  Future<void> requestWithdrawal({
    required String providerId,
    required double amount,
    required Map<String, dynamic> bankDetails,
  });
}

class EarningsRemoteDataSourceImpl implements EarningsRemoteDataSource {
  EarningsRemoteDataSourceImpl(this.firestore);
  final FirebaseFirestore firestore;

  @override
  Stream<EarningEntity> getEarningsStream(String providerId) {
    final providerStream = firestore.collection('providers').doc(providerId).snapshots();
    final walletStream = firestore.collection('providers').doc(providerId).collection('wallet').doc('info').snapshots();
    final transactionsStream = firestore
        .collection('providers')
        .doc(providerId)
        .collection('transactions')
        .orderBy('createdAt', descending: true)
        .snapshots();

    return Rx.combineLatest3<DocumentSnapshot, DocumentSnapshot, QuerySnapshot, EarningEntity>(
      providerStream,
      walletStream,
      transactionsStream,
      (providerDoc, walletDoc, transactionsSnap) {
        final providerData = providerDoc.data() as Map<String, dynamic>? ?? {};
        final walletData = walletDoc.data() as Map<String, dynamic>? ?? {};
        
        double totalWithdrawn = 0;
        final transactions = transactionsSnap.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final amount = (data['amount'] as num).toDouble();
          final type = data['type'] as String;
          final status = data['status'] as String? ?? 'completed';
          
          if (type == 'withdrawal' && status != 'rejected') {
            totalWithdrawn += amount;
          }

          return TransactionEntity(
            id: doc.id,
            bookingId: data['bookingId'] != null ? "${data['bookingId']}|${data['serviceName'] ?? ''}" : null,
            amount: amount,
            commission: (data['commission'] as num? ?? 0.0).toDouble(),
            netAmount: (data['netAmount'] as num? ?? amount).toDouble(),
            createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
            type: type,
            status: status,
            rejectionReason: data['rejectionReason'] as String?,
            bankDetails: data['bankDetails'] as Map<String, dynamic>?,
            requestedAt: (data['requestedAt'] as Timestamp?)?.toDate(),
          );
        }).toList();

        // Use fields from root doc, wallet doc, or fallback to manual calculation
        double totalEarnings = (providerData['totalEarnings'] as num? ?? 
                               providerData['totalEarned'] as num? ?? 
                               walletData['totalEarnings'] as num? ?? 
                               walletData['totalEarned'] as num?)?.toDouble() ?? 0.0;
                               
        double availableBalance = (providerData['walletBalance'] as num? ?? 
                                  providerData['balance'] as num? ??
                                  walletData['walletBalance'] as num? ??
                                  walletData['balance'] as num?)?.toDouble() ?? 0.0;

        // Fallback calculation if fields are missing or 0
        if (totalEarnings == 0) {
          for (final t in transactions) {
            if (t.type == 'earning' || t.type == 'booking') {
              totalEarnings += t.amount;
            }
          }
        }
        
        if (availableBalance == 0 && totalEarnings > 0) {
          availableBalance = totalEarnings - totalWithdrawn;
        }

        return EarningEntity(
          totalEarnings: totalEarnings,
          totalWithdrawn: totalWithdrawn,
          availableBalance: availableBalance,
          transactions: transactions,
        );
      },
    );
  }

  @override
  Future<void> requestWithdrawal({
    required String providerId,
    required double amount,
    required Map<String, dynamic> bankDetails,
  }) async {
    final batch = firestore.batch();
    
    final transactionRef = firestore.collection('transactions').doc();
    batch.set(transactionRef, {
      'providerId': providerId,
      'userId': providerId, // For consistency with admin panel query
      'type': 'withdrawal',
      'amount': amount,
      'status': 'pending',
      'bankDetails': bankDetails,
      'requestedAt': FieldValue.serverTimestamp(),
      'createdAt': FieldValue.serverTimestamp(),
    });

    // Note: In a real app, you'd also update the wallet balance here if you have a separate wallet doc.
    // The getEarningsStream currently calculates balance from transactions.

    await batch.commit();
  }
}

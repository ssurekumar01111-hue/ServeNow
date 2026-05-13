import 'dart:async';
import 'package:customer/features/auth/presentation/providers/auth_provider.dart';
import 'package:customer/features/wallet/data/wallet_remote_data_source.dart';
import 'package:customer/features/wallet/domain/wallet_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WalletNotifier extends StreamNotifier<WalletEntity> {
  @override
  Stream<WalletEntity> build() {
    final user = ref.watch(authNotifierProvider).value;
    if (user == null) {
      return Stream.value(const WalletEntity(
        id: '',
        userId: '',
        balance: 0,
        currency: 'INR',
      ));
    }
    return ref.watch(walletDataSourceProvider).getWallet(user.uid);
  }

  Future<void> addMoney(double amount, String paymentId) async {
    final user = ref.read(authNotifierProvider).value;
    if (user == null) return;
    await ref.read(walletDataSourceProvider).addMoneyViaRazorpay(user.uid, amount, paymentId);
  }
}

final walletProvider = StreamNotifierProvider<WalletNotifier, WalletEntity>(WalletNotifier.new);

class TransactionsNotifier extends StreamNotifier<List<TransactionEntity>> {
  @override
  Stream<List<TransactionEntity>> build() {
    final user = ref.watch(authNotifierProvider).value;
    if (user == null) {
      return Stream.value([]);
    }
    return ref.watch(walletDataSourceProvider).getTransactions(user.uid);
  }
}

final transactionsProvider = StreamNotifierProvider<TransactionsNotifier, List<TransactionEntity>>(TransactionsNotifier.new);

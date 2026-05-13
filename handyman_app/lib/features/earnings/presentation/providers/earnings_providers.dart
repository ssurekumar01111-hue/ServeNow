import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/features/auth/presentation/providers/auth_provider.dart';
import 'package:handyman/features/earnings/data/wallet_repository.dart';

final walletStreamProvider = StreamProvider.family<DocumentSnapshot<Map<String, dynamic>>, String>((ref, id) {
  return ref.watch(walletRepositoryProvider).getWalletStream(id);
});

final transactionsStreamProvider = StreamProvider.family<QuerySnapshot<Map<String, dynamic>>, String>((ref, id) {
  return ref.watch(walletRepositoryProvider).getTransactions(id);
});

final earningsNotifierProvider = AsyncNotifierProvider<EarningsNotifier, void>(EarningsNotifier.new);

class EarningsNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> topUp(double amount, {String? paymentId}) async {
    state = const AsyncLoading();
    try {
      final user = ref.read(authNotifierProvider).value!;
      await ref.read(walletRepositoryProvider).topUpWallet(
        handymanId: user.uid,
        amount: amount,
        razorpayPaymentId: paymentId,
      );
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> withdraw(double amount, String bankDetails) async {
    state = const AsyncLoading();
    try {
      final user = ref.read(authNotifierProvider).value!;
      await ref.read(walletRepositoryProvider).requestWithdrawal(
        handymanId: user.uid,
        amount: amount,
        bankDetails: bankDetails,
      );
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

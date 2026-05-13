import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/core/providers/firebase_providers.dart';
import 'package:provider/features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/features/wallet/data/datasources/wallet_remote_datasource.dart';

final walletRemoteDataSourceProvider = Provider<WalletRemoteDataSource>((ref) {
  return WalletRemoteDataSourceImpl(ref.watch(firestoreProvider));
});

final walletNotifierProvider = AsyncNotifierProvider<WalletNotifier, void>(WalletNotifier.new);

class WalletNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> requestWithdrawal(double amount, String paymentInfo) async {
    state = const AsyncLoading();
    try {
      final user = ref.read(authNotifierProvider).value!;
      await ref.read(walletRemoteDataSourceProvider).requestWithdrawal(user.uid, amount, paymentInfo);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/core/providers/firebase_providers.dart';
import 'package:provider/features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/features/earnings/domain/entities/earning_entity.dart';
import 'package:provider/features/earnings/data/datasources/earnings_remote_datasource.dart';

final earningsRemoteDataSourceProvider = Provider<EarningsRemoteDataSource>((ref) {
  return EarningsRemoteDataSourceImpl(ref.watch(firestoreProvider));
});

final earningsProvider = StreamNotifierProvider<EarningsNotifier, EarningEntity>(EarningsNotifier.new);

class EarningsNotifier extends StreamNotifier<EarningEntity> {
  @override
  Stream<EarningEntity> build() {
    final user = ref.watch(authNotifierProvider).value;
    if (user == null) return Stream.empty();
    return ref.watch(earningsRemoteDataSourceProvider).getEarningsStream(user.uid);
  }

  Future<void> requestWithdrawal(double amount, Map<String, dynamic> bankDetails) async {
    final user = ref.read(authNotifierProvider).value;
    if (user == null) return;
    await ref.read(earningsRemoteDataSourceProvider).requestWithdrawal(
      providerId: user.uid,
      amount: amount,
      bankDetails: bankDetails,
    );
  }
}

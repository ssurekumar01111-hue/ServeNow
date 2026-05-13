import 'package:customer/core/widgets/shimmer_loader.dart';
import 'package:customer/features/wallet/presentation/add_money_bottom_sheet.dart';
import 'package:customer/features/wallet/presentation/wallet_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class WalletScreen extends ConsumerWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletAsync = ref.watch(walletProvider);
    final transactionsAsync = ref.watch(transactionsProvider);
    final currencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹');

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wallet'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(walletProvider);
          ref.invalidate(transactionsProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Balance Card
              walletAsync.when(
                data: (wallet) => Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: [
                        Text(
                          'Available Balance',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.7),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          currencyFormat.format(wallet.balance),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => const AddMoneyBottomSheet(),
                            );
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Add Money'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.surface,
                            foregroundColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                loading: () => _buildBalanceShimmer(context),
                error: (e, st) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red, size: 48),
                      const SizedBox(height: 16),
                      Text('Something went wrong: $e', textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref.invalidate(walletProvider),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Recent Transactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Transactions List
              transactionsAsync.when(
                data: (transactions) {
                  if (transactions.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text('No transactions found.'),
                      ),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: transactions.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final tx = transactions[index];
                      final isCredit = tx.type == 'credit';
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: isCredit
                              ? Colors.green.withValues(alpha: 0.1)
                              : Colors.red.withValues(alpha: 0.1),
                          child: Icon(
                            isCredit ? Icons.arrow_upward : Icons.arrow_downward,
                            color: isCredit ? Colors.green : Colors.red,
                          ),
                        ),
                        title: Text(tx.description),
                        subtitle: Text(
                          DateFormat('dd MMM yyyy, hh:mm a').format(tx.createdAt),
                        ),
                        trailing: Text(
                          '${isCredit ? "+" : "-"} ${currencyFormat.format(tx.amount)}',
                          style: TextStyle(
                            color: isCredit ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => _buildTransactionsShimmer(context),
                error: (e, st) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red, size: 48),
                      const SizedBox(height: 16),
                      Text('Something went wrong: $e', textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref.invalidate(transactionsProvider),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      highlightColor: Theme.of(context).colorScheme.surface,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget _buildTransactionsShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      highlightColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: List.generate(
          5,
          (index) => ListTile(
            leading: const CircleAvatar(),
            title: Container(
              height: 10,
              width: double.infinity,
              color: Theme.of(context).colorScheme.surface,
            ),
            subtitle: Container(
              height: 10,
              width: 100,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
        ),
      ),
    );
  }
}

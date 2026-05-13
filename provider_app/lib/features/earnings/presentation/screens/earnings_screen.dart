import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:provider/core/widgets/shimmer_loader.dart';
import 'package:provider/features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/features/earnings/presentation/providers/earnings_providers.dart';
import 'package:provider/features/earnings/domain/entities/earning_entity.dart';
import 'package:provider/features/profile/presentation/providers/profile_providers.dart';

class EarningsScreen extends ConsumerWidget {
  const EarningsScreen({super.key});

  void _showWithdrawSheet(BuildContext context, EarningEntity earnings) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => WithdrawBottomSheet(earnings: earnings),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final earningsAsync = ref.watch(earningsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Earnings'),
        actions: [
          earningsAsync.when(
            data: (earnings) => TextButton(
              onPressed: earnings.availableBalance >= 100 ? () => _showWithdrawSheet(context, earnings) : null,
              child: const Text('Withdraw', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: earningsAsync.when(
        data: (earnings) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SummarySection(earnings),
              const SizedBox(height: 24),
              const Text('Recent Transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              earnings.transactions.isEmpty
                  ? const Center(child: Padding(padding: EdgeInsets.symmetric(vertical: 40), child: Text('No transactions yet', style: TextStyle(color: Colors.grey))))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: earnings.transactions.length,
                      itemBuilder: (context, index) {
                        final t = earnings.transactions[index];
                        return _TransactionCard(transaction: t);
                      },
                    ),
            ],
          ),
        ),
        loading: () => const ShimmerLoader(),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _SummarySection(EarningEntity earnings) {
    return Row(
      children: [
        _SummaryCard('Total Earnings', '₹${earnings.totalEarnings.toStringAsFixed(0)}', Colors.blue),
        const SizedBox(width: 12),
        _SummaryCard('Available Balance', '₹${earnings.availableBalance.toStringAsFixed(0)}', Colors.green),
      ],
    );
  }

  Widget _SummaryCard(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(value, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final TransactionEntity transaction;
  const _TransactionCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isWithdrawal = transaction.type == 'withdrawal';
    final statusColor = transaction.status == 'pending' ? Colors.orange : (transaction.status == 'rejected' ? Colors.red : Colors.green);

    String? serviceName;
    if (!isWithdrawal && transaction.bookingId != null && transaction.bookingId!.contains('|')) {
      final parts = transaction.bookingId!.split('|');
      if (parts.length > 1 && parts[1].isNotEmpty) {
        serviceName = parts[1];
      }
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    isWithdrawal ? 'Withdrawal' : (serviceName ?? 'Service Earning'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${isWithdrawal ? "-" : "+"}₹${transaction.amount.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isWithdrawal ? Colors.red : Colors.green,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('dd MMM yyyy').format(transaction.createdAt),
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    transaction.status.toUpperCase(),
                    style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            if (transaction.rejectionReason != null) ...[
              const SizedBox(height: 8),
              Text(
                'Reason: \${transaction.rejectionReason}',
                style: const TextStyle(color: Colors.red, fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class WithdrawBottomSheet extends ConsumerStatefulWidget {
  final EarningEntity earnings;
  const WithdrawBottomSheet({super.key, required this.earnings});

  @override
  ConsumerState<WithdrawBottomSheet> createState() => _WithdrawBottomSheetState();
}

class _WithdrawBottomSheetState extends ConsumerState<WithdrawBottomSheet> {
  final _amountController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final amount = double.tryParse(_amountController.text) ?? 0;
    if (amount < 100) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Minimum withdrawal amount is ₹100')));
      return;
    }
    if (amount > widget.earnings.availableBalance) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Insufficient balance')));
      return;
    }

    setState(() => _isLoading = true);
    try {
      final profile = ref.read(providerProfileProvider).value!;
      
      final bankDetails = {
        'accountName': profile.bankAccountName,
        'accountNumber': profile.bankAccountNumber,
        'ifscCode': profile.bankIFSC,
      };

      await ref.read(earningsProvider.notifier).requestWithdrawal(amount, bankDetails);
      
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Withdrawal request submitted!')));
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(providerProfileProvider).value;
    final maskedAccount = profile?.bankAccountNumber != null && profile!.bankAccountNumber!.length > 4 
        ? 'XXXX XXXX \${profile.bankAccountNumber!.substring(profile.bankAccountNumber!.length - 4)}'
        : 'Not set';

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 20, left: 20, right: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Request Withdrawal', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Available Balance: ₹\${widget.earnings.availableBalance.toStringAsFixed(2)}', style: TextStyle(color: Colors.grey.shade600)),
          const SizedBox(height: 24),
          
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Amount to withdraw',
              prefixText: '₹ ',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('BANK DETAILS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
                const SizedBox(height: 8),
                Text('Account: \${maskedAccount}', style: const TextStyle(fontWeight: FontWeight.w600)),
                Text('IFSC: \${profile?.bankIFSC ?? "N/A"}'),
                Text('Name: \${profile?.bankAccountName ?? "N/A"}'),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _isLoading ? null : _submit,
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), backgroundColor: Colors.indigo, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: _isLoading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('Request Withdrawal'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

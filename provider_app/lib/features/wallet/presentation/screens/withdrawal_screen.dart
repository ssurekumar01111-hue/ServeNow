import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/features/wallet/presentation/providers/wallet_providers.dart';

class WithdrawalScreen extends ConsumerStatefulWidget {
  const WithdrawalScreen({super.key});

  @override
  ConsumerState<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends ConsumerState<WithdrawalScreen> {
  final _amountController = TextEditingController();
  final _infoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Withdraw Funds')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _amountController, decoration: const InputDecoration(labelText: 'Amount'), keyboardType: TextInputType.number),
            TextField(controller: _infoController, decoration: const InputDecoration(labelText: 'Bank Account / UPI ID')),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                ref.read(walletNotifierProvider.notifier).requestWithdrawal(
                  double.parse(_amountController.text),
                  _infoController.text,
                );
                Navigator.pop(context);
              },
              child: const Text('Submit Request'),
            ),
          ],
        ),
      ),
    );
  }
}

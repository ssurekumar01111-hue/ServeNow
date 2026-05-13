import 'package:customer/core/services/razorpay_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddMoneyBottomSheet extends ConsumerStatefulWidget {
  const AddMoneyBottomSheet({super.key});

  @override
  ConsumerState<AddMoneyBottomSheet> createState() => _AddMoneyBottomSheetState();
}

class _AddMoneyBottomSheetState extends ConsumerState<AddMoneyBottomSheet> {
  final _amountController = TextEditingController();
  final RazorpayService _razorpayService = RazorpayService();
  double _selectedAmount = 100;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _razorpayService.init(
      onSuccess: _handlePaymentSuccess,
      onFailure: _handlePaymentError,
      onWallet: (response) {},
    );
    _amountController.text = _selectedAmount.toStringAsFixed(0);
  }

  @override
  void dispose() {
    _razorpayService.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _handlePaymentSuccess(dynamic response) {
    // Stubbed for Codester release
  }

  void _handlePaymentError(dynamic response) {
    // Stubbed for Codester release
  }

  void _startPayment() async {
    final amount = double.tryParse(_amountController.text) ?? 0;
    if (amount < 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Minimum top-up: ₹100')),
      );
      return;
    }

    if (!mounted) return;
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF2D81F7),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'razorpay',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            const SizedBox(width: 8),
            const Expanded(child: Text('Setup Required', style: TextStyle(fontSize: 18))),
          ],
        ),
        content: const Text(
          'Online payment is not configured yet.\n\n'
          'To enable Razorpay:\n'
          '1. Create account at razorpay.com\n'
          '2. Get your Key ID & Key Secret\n'
          '3. Add keys to functions/index.js\n'
          '4. Update Key ID in razorpay_service.dart\n\n'
          'See the Firebase Setup Guide included in the package.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final amounts = [100, 200, 500, 1000];

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Add Money to Wallet',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            children: amounts.map((amount) {
              final isSelected = _selectedAmount == amount.toDouble();
              return ChoiceChip(
                label: Text('₹$amount'),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      _selectedAmount = amount.toDouble();
                      _amountController.text = amount.toString();
                    });
                  }
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter Custom Amount',
              prefixText: '₹ ',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _selectedAmount = double.tryParse(value) ?? 0;
              });
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isLoading ? null : _startPayment,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: _isLoading 
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Pay Now'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

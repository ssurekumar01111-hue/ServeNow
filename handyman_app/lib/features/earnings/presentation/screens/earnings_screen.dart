import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/core/constants/booking_status.dart';
import 'package:handyman/core/theme/app_colors.dart';
import 'package:handyman/features/auth/presentation/providers/auth_provider.dart';
import 'package:handyman/features/earnings/data/wallet_repository.dart';
import 'package:handyman/features/earnings/presentation/providers/earnings_providers.dart';
import 'package:handyman/features/profile/presentation/providers/profile_providers.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class EarningsScreen extends ConsumerStatefulWidget {
  const EarningsScreen({super.key});

  @override
  ConsumerState<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends ConsumerState<EarningsScreen> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle topup success
    ref.read(earningsNotifierProvider.notifier).topUp(500, paymentId: response.paymentId);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Top-up successful!')),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment failed: ${response.message}')),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  void _startPayment() {
    var options = {
      'key': 'rzp_test_XXXXXXXXXXXXXX',
      'amount': 50000, // 500 INR in paise
      'name': 'ServeNow Handyman',
      'description': 'Wallet Top-up',
      'prefill': {'contact': '8888888888', 'email': 'handyman@servenow.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authNotifierProvider).value;
    if (user == null) return const Scaffold(body: Center(child: Text('Please login')));

    final profileAsync = ref.watch(handymanProfileProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Earnings & Wallet', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: profileAsync.when(
        data: (profile) {
          final balance = profile?.walletBalance ?? 0.0;
          final totalEarned = profile?.totalEarnings ?? 0.0;
          // We don't have totalWithdrawn in profile yet, can calculate or use 0
          final totalWithdrawn = totalEarned - balance; 

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildBalanceCard(balance),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          _buildStatCard('Total Earned', '₹${totalEarned.toStringAsFixed(2)}', Icons.trending_up, Colors.green),
                          const SizedBox(width: 16),
                          _buildStatCard('Withdrawn', '₹${totalWithdrawn.toStringAsFixed(2)}', Icons.account_balance_wallet, Colors.orange),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Recent Transactions',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                          ),
                          TextButton(onPressed: () {}, child: const Text('View All')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              _buildTransactionList(user.uid),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildBalanceCard(double balance) {
    return FadeInDown(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.primaryGradient,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              'Available Balance',
              style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16, fontFamily: 'Poppins'),
            ),
            const SizedBox(height: 8),
            Text(
              '₹${balance.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _showWithdrawDialog(balance),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('Withdraw', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _startPayment,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white, width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('Top Up', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 16),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
            Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList(String uid) {
    final transactionsAsync = ref.watch(transactionsStreamProvider(uid));

    return transactionsAsync.when(
      data: (snapshot) {
        final docs = snapshot.docs;
        if (docs.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(child: Padding(padding: EdgeInsets.all(40), child: Text('No transactions yet'))),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final data = docs[index].data();
              return _TransactionItem(transaction: data);
            },
            childCount: docs.length,
          ),
        );
      },
      loading: () => const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
      error: (e, st) => SliverToBoxAdapter(child: Center(child: Text('Error: $e'))),
    );
  }

  void _showWithdrawDialog(double balance) {
    final amountController = TextEditingController();
    final bankController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Withdraw Funds'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount', prefixText: '₹'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: bankController,
              decoration: const InputDecoration(labelText: 'Bank Account / UPI'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text) ?? 0;
              if (amount > balance) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Insufficient balance')));
                return;
              }
              if (amount < 100) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Minimum withdrawal is ₹100')));
                return;
              }
              ref.read(earningsNotifierProvider.notifier).withdraw(amount, bankController.text);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Withdrawal request submitted!')));
            },
            child: const Text('Withdraw'),
          ),
        ],
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  const _TransactionItem({required this.transaction});
  final Map<String, dynamic> transaction;

  @override
  Widget build(BuildContext context) {
    final type = transaction['type'] as String;
    final double amount = (transaction['amount'] as num? ?? 0).toDouble();
    final createdAt = (transaction['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now();
    final status = transaction['status'] as String? ?? BookingStatuses.completed;
    
    IconData icon;
    Color color;
    String title;
    
    switch (type) {
      case 'earning':
        icon = Icons.arrow_upward;
        color = Colors.green;
        title = 'Job Earning';
        break;
      case 'withdrawal':
        icon = Icons.arrow_downward;
        color = status == BookingStatuses.pending ? Colors.orange : (status == 'rejected' ? Colors.red : Colors.green);
        title = 'Withdrawal';
        break;
      case 'topup':
        icon = Icons.add_circle_outline;
        color = Colors.blue;
        title = 'Wallet Top-up';
        break;
      case 'cash':
        icon = Icons.payments;
        color = Colors.teal;
        title = 'Cash Collection';
        break;
      default:
        icon = Icons.help_outline;
        color = Colors.grey;
        title = 'Other';
    }

    return FadeInRight(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5, offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(DateFormat('dd MMM yyyy, hh:mm a').format(createdAt), style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${amount > 0 ? "+" : ""}₹${amount.abs().toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: amount > 0 ? Colors.green : Colors.red),
                ),
                if (status != BookingStatuses.completed)
                  Text(
                    status.toUpperCase(),
                    style: TextStyle(color: status == BookingStatuses.pending ? Colors.orange : Colors.red, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

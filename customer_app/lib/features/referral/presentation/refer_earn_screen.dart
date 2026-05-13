import 'package:customer/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

class ReferEarnScreen extends ConsumerWidget {
  const ReferEarnScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authNotifierProvider).value;
    final referralCode = user?.referralCode ?? '------';

    return Scaffold(
      appBar: AppBar(title: const Text('Refer & Earn')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.card_giftcard, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              'Refer your friends and earn rewards!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                children: [
                  const Text('Your Referral Code'),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        referralCode,
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 5),
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: referralCode));
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Code copied!')));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Share.share('Use my code $referralCode on ServeNow to get exciting discounts on home services!');
              },
              icon: const Icon(Icons.share),
              label: const Text('Share Code'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 50),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('How it works', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
            _buildStep(1, 'Invite your friends', 'Share your referral code with your friends and family.'),
            _buildStep(2, 'They sign up', 'Your friends sign up on ServeNow using your referral code.'),
            _buildStep(3, 'You get rewards', 'Earn ₹50 in your wallet after their first successful booking.'),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(int number, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 15, child: Text('$number')),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(description, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

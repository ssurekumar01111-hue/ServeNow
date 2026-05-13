import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HelpSupportScreen extends ConsumerStatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  ConsumerState<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends ConsumerState<HelpSupportScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;

  final List<Map<String, String>> _faqs = [
    {'q': 'How do I book a service?', 'a': 'Navigate to the home screen, select a category, choose a provider, and follow the booking flow.'},
    {'q': 'How can I cancel a booking?', 'a': 'Go to My Bookings, select the pending booking, and click Cancel.'},
    {'q': 'Is my payment secure?', 'a': 'Yes, we use Razorpay for secure transactions.'},
    {'q': 'How does the wallet work?', 'a': 'You can add money to your wallet and use it for seamless checkout.'},
    {'q': 'Can I track my handyman?', 'a': 'Yes, once a handyman is en route, you can track them on the map.'},
    {'q': 'How do referrals work?', 'a': 'Share your code from the Refer & Earn screen. You get rewards when they complete their first booking.'},
    {'q': 'What if I am not satisfied?', 'a': 'You can contact support or leave a review for the provider.'},
    {'q': 'How do I change my address?', 'a': 'Go to Profile -> Saved Addresses to manage your locations.'},
  ];

  Future<void> _submitTicket() async {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty || _messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      final user = ref.read(authNotifierProvider).value;
      await FirebaseFirestore.instance.collection('support_tickets').add({
        'userId': user?.uid ?? 'guest',
        'name': _nameController.text,
        'email': _emailController.text,
        'message': _messageController.text,
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'open',
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ticket submitted successfully!')));
        _messageController.clear();
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Frequently Asked Questions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _faqs.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  title: Text(_faqs[index]['q']!),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(_faqs[index]['a']!),
                    )
                  ],
                );
              },
            ),
            const SizedBox(height: 30),
            const Text('Contact Us', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            TextField(controller: _messageController, maxLines: 4, decoration: const InputDecoration(labelText: 'Message', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isSubmitting ? null : _submitTicket,
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              child: _isSubmitting ? const CircularProgressIndicator() : const Text('Submit Ticket'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/core/router/app_routes.dart';
import 'package:provider/core/theme/app_colors.dart';
import 'package:provider/features/auth/presentation/providers/auth_provider.dart';

class VerificationPendingScreen extends ConsumerStatefulWidget {
  const VerificationPendingScreen({super.key});

  @override
  ConsumerState<VerificationPendingScreen> createState() => _VerificationPendingScreenState();
}

class _VerificationPendingScreenState extends ConsumerState<VerificationPendingScreen> {
  StreamSubscription? _subscription;
  Map<String, dynamic>? _providerData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _listenForApproval();
  }

  void _listenForApproval() {
    final user = ref.read(authNotifierProvider).value;
    if (user == null) return;

    _subscription = FirebaseFirestore.instance
      .collection('providers')
      .doc(user.uid)
      .snapshots()
      .listen((doc) {
        if (mounted) {
          setState(() {
            _providerData = doc.data();
            _isLoading = false;
          });
        }
        if (doc.exists && (doc.data()?['onboardingStatus'] == 'approved')) {
          debugPrint('🎉 Provider approved! Navigating to dashboard');
          if (mounted) context.go(AppRoutes.dashboard);
        }
      });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final businessName = _providerData?['businessName'] as String? ?? 'Your Business';
    final categories = (_providerData?['categories'] as List<dynamic>?)?.join(', ') ?? 'Services';
    final isApproved = _providerData?['isApproved'] as bool? ?? false;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Animated clock/hourglass icon
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(seconds: 2),
                builder: (context, value, child) {
                  return Transform.rotate(
                    angle: value * 2 * 3.14159,
                    child: const Icon(Icons.hourglass_bottom_rounded, size: 80, color: AppColors.primary),
                  );
                },
                onEnd: () => setState(() {}), // Trigger rebuild for continuous animation if needed
              ),
              const SizedBox(height: 32),
              const Text(
                'Application Under Review',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Our team will review your documents within 24-48 hours. You will be notified once approved.',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              
              // Submitted Info Card
              Card(
                elevation: 0,
                color: Colors.grey[50],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: Colors.grey[200]!)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow('Business Name', businessName),
                      const Divider(height: 24),
                      _buildInfoRow('Categories', categories),
                      const Divider(height: 24),
                      const Text('Submitted Documents', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(height: 12),
                      _buildDocItem('Business License'),
                      _buildDocItem('Owner ID Proof'),
                      _buildDocItem('Profile Photo'),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              
              ElevatedButton(
                onPressed: () {
                  setState(() => _isLoading = true);
                  _listenForApproval();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 54),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Refresh Status', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () => ref.read(authNotifierProvider.notifier).signOut(),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 54),
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Logout', style: TextStyle(color: Colors.red, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }

  Widget _buildDocItem(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 18),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

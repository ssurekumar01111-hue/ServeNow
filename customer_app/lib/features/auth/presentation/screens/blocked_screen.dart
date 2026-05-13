import 'package:customer/core/theme/app_colors.dart';
import 'package:customer/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class BlockedScreen extends ConsumerWidget {
  const BlockedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.block_flipped,
              size: 100,
              color: Colors.red,
            ),
            const SizedBox(height: 32),
            const Text(
              'Account Suspended',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Your account has been suspended due to a violation of our terms of service. If you believe this is a mistake, please contact our support team.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 48),
            // In a real app, these values would come from Firestore app_settings/platform
            _SupportButton(
              icon: Icons.phone,
              label: 'Call Support',
              onTap: () => _launchUrl('tel:+919876543210'),
            ),
            const SizedBox(height: 16),
            _SupportButton(
              icon: Icons.email,
              label: 'Email Support',
              onTap: () => _launchUrl('mailto:support@servenow.com'),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () => ref.read(authNotifierProvider.notifier).signOut(),
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class _SupportButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SupportButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}

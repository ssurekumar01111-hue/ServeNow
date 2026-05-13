import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:handyman/core/router/app_routes.dart';
import 'package:handyman/core/theme/app_colors.dart';
import 'package:handyman/features/auth/presentation/providers/auth_provider.dart';
import 'package:handyman/features/profile/presentation/providers/profile_providers.dart';

class HandymanPendingApprovalScreen extends ConsumerWidget {
  const HandymanPendingApprovalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to profile changes for real-time approval update
    ref.listen(handymanProfileProvider, (previous, next) {
      next.whenData((profile) {
        if (profile != null && profile.onboardingStatus == 'approved' && profile.isApproved) {
          debugPrint('✅ Handyman approved in real-time! Navigating to dashboard.');
          context.go(AppRoutes.dashboard);
        }
      });
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.hourglass_empty_rounded,
                size: 100,
                color: AppColors.primary,
              ),
              const SizedBox(height: 32),
              const Text(
                'Application Pending',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Your application is under review. You will be notified once approved by admin.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => ref.read(authNotifierProvider.notifier).signOut(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: AppColors.primary),
                    ),
                  ),
                  child: const Text('Sign Out'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

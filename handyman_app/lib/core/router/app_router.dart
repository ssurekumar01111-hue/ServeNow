import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:handyman/core/router/app_routes.dart';
import 'package:handyman/features/auth/presentation/providers/auth_provider.dart';
import 'package:handyman/features/auth/presentation/screens/handyman_onboarding_screen.dart';
import 'package:handyman/features/auth/presentation/screens/handyman_pending_approval_screen.dart';
import 'package:handyman/features/auth/presentation/screens/handyman_rejected_screen.dart';
import 'package:handyman/features/auth/presentation/screens/otp_verify_screen.dart';
import 'package:handyman/features/auth/presentation/screens/phone_login_screen.dart';
import 'package:handyman/features/auth/presentation/screens/splash_screen.dart';
import 'package:handyman/features/chat/presentation/screens/chat_screen.dart';
import 'package:handyman/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:handyman/features/dashboard/presentation/widgets/main_scaffold.dart';
import 'package:handyman/features/earnings/presentation/screens/earnings_screen.dart';
import 'package:handyman/features/jobs/presentation/screens/job_detail_screen.dart';
import 'package:handyman/features/jobs/presentation/screens/job_list_screen.dart';
import 'package:handyman/features/jobs/presentation/screens/otp_verify_screen.dart' as jobs;
import 'package:handyman/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:handyman/features/profile/presentation/screens/profile_screen.dart';
import 'package:handyman/features/profile/presentation/screens/settings_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authNotifier = ref.watch(authNotifierProvider.notifier);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    redirect: (context, state) async {
      final firebaseUser = FirebaseAuth.instance.currentUser;
      final isOtpSent = authNotifier.isOtpSent;
      final currentLocation = state.matchedLocation;

      debugPrint('🚀 Router redirect: firebaseUser=${firebaseUser?.uid} isOtpSent=$isOtpSent location=$currentLocation');

      // 1. Never redirect if OTP is in progress
      if (isOtpSent && currentLocation == AppRoutes.otpVerify) return null;
      if (isOtpSent) return null;

      // 2. Allow ALL non-protected routes
      final isProtectedRoute = AppRoutes.protectedRoutes.contains(currentLocation) ||
                               currentLocation.startsWith('/jobs/') ||
                               currentLocation.startsWith('/chat/');
                               
      if (!isProtectedRoute) return null;

      // 3. For protected routes, check login
      if (firebaseUser == null) {
        debugPrint('🚫 Protected route: $currentLocation but not logged in. Redirecting to login.');
        return AppRoutes.login;
      }

      // 4. Fetch handyman document
      final doc = await FirebaseFirestore.instance
          .collection('handymen')
          .doc(firebaseUser.uid)
          .get();

      // 5. Doc does not exist at all -> new user, go to onboarding
      if (!doc.exists) {
        debugPrint('📝 No handyman doc found. Redirecting to onboarding.');
        return AppRoutes.onboarding;
      }

      final data = doc.data()!;
      final onboardingStatus = data['onboardingStatus'] as String?;
      final isApproved = data['isApproved'] as bool? ?? false;

      debugPrint('🔍 Handyman Status: onboardingStatus=$onboardingStatus isApproved=$isApproved');

      // 6. Doc exists but onboardingStatus field is missing (Existing Handymen)
      if (onboardingStatus == null) {
        if (isApproved) {
          debugPrint('✅ Existing approved handyman skipping onboarding.');
          if (currentLocation == AppRoutes.onboarding || 
              currentLocation == AppRoutes.pendingApproval || 
              currentLocation == AppRoutes.rejected ||
              currentLocation == AppRoutes.signUp) {
            return AppRoutes.dashboard;
          }
          return null;
        } else {
          debugPrint('⚠️ Existing but not approved handyman redirecting to onboarding.');
          if (currentLocation != AppRoutes.onboarding) return AppRoutes.onboarding;
          return null;
        }
      }

      // 7. onboardingStatus field exists
      if (onboardingStatus == 'approved' && isApproved) {
        if (currentLocation == AppRoutes.onboarding || 
            currentLocation == AppRoutes.pendingApproval || 
            currentLocation == AppRoutes.rejected ||
            currentLocation == AppRoutes.signUp) {
          return AppRoutes.dashboard;
        }
        return null;
      }

      if (onboardingStatus == 'pending') {
        debugPrint('⏳ Application pending approval.');
        if (currentLocation != AppRoutes.pendingApproval) return AppRoutes.pendingApproval;
        return null;
      }

      if (onboardingStatus == 'rejected') {
        debugPrint('❌ Application rejected.');
        if (currentLocation != AppRoutes.rejected) return AppRoutes.rejected;
        return null;
      }

      // fallback
      if (currentLocation != AppRoutes.onboarding) return AppRoutes.onboarding;
      return null;
    },
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: AppRoutes.login, builder: (context, state) => const PhoneLoginScreen()),
      GoRoute(path: AppRoutes.onboarding, builder: (context, state) => const HandymanOnboardingScreen()),
      GoRoute(path: AppRoutes.signUp, builder: (context, state) => const HandymanOnboardingScreen()),
      GoRoute(path: AppRoutes.pendingApproval, builder: (context, state) => const HandymanPendingApprovalScreen()),
      GoRoute(path: AppRoutes.rejected, builder: (context, state) => const HandymanRejectedScreen()),
      GoRoute(
        path: AppRoutes.otpVerify, 
        builder: (context, state) {
          final verificationId = state.extra as String? ?? authNotifier.verificationId ?? '';
          return OTPVerifyScreen(verificationId: verificationId);
        }
      ),
      GoRoute(path: AppRoutes.notifications, builder: (context, state) => const NotificationsScreen()),
      GoRoute(path: AppRoutes.settings, builder: (context, state) => const SettingsScreen()),
      
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => MainScaffold(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [GoRoute(path: AppRoutes.dashboard, builder: (context, state) => const DashboardScreen())]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.jobs,
              builder: (context, state) => const JobListScreen(),
              routes: [
                GoRoute(path: ':id', builder: (context, state) => JobDetailScreen(jobId: state.pathParameters['id']!)),
                GoRoute(path: ':id/verify', builder: (context, state) => jobs.OTPVerifyScreen(jobId: state.pathParameters['id']!)),
              ],
            )
          ]),
          StatefulShellBranch(routes: [GoRoute(path: AppRoutes.earnings, builder: (context, state) => const EarningsScreen())]),
          StatefulShellBranch(routes: [GoRoute(path: AppRoutes.profile, builder: (context, state) => const ProfileScreen())]),
        ],
      ),
      GoRoute(path: AppRoutes.chat, builder: (context, state) => ChatScreen(bookingId: state.pathParameters['id']!, otherName: 'Customer')),
    ],
  );
});

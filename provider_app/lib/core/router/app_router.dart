import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/core/router/app_routes.dart';
import 'package:provider/features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/features/auth/presentation/screens/otp_verify_screen.dart';
import 'package:provider/features/auth/presentation/screens/phone_login_screen.dart';
import 'package:provider/features/auth/presentation/screens/splash_screen.dart';
import 'package:provider/features/bookings/presentation/screens/booking_detail_screen.dart';
import 'package:provider/features/bookings/presentation/screens/bookings_screen.dart';
import 'package:provider/features/chat/presentation/screens/chat_screen.dart';
import 'package:provider/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:provider/features/dashboard/presentation/widgets/main_scaffold.dart';
import 'package:provider/features/earnings/presentation/screens/earnings_screen.dart';
import 'package:provider/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:provider/features/profile/presentation/screens/profile_screen.dart';
import 'package:provider/features/profile/presentation/screens/settings_screen.dart';
import 'package:provider/features/registration/presentation/screens/registration_screen.dart';
import 'package:provider/features/registration/presentation/screens/verification_pending_screen.dart';
import 'package:provider/features/services/presentation/screens/add_service_screen.dart';
import 'package:provider/features/services/presentation/screens/my_services_screen.dart';
import 'package:provider/features/wallet/presentation/screens/withdrawal_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authNotifier = ref.watch(authNotifierProvider.notifier);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    onException: (context, state, router) {
      debugPrint('🚨 GoRouter exception: ${state.error}');
      debugPrint('🚨 Attempted path: ${state.uri}');
    },
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: AppRoutes.login, builder: (context, state) => const PhoneLoginScreen()),
      GoRoute(
        path: AppRoutes.otpVerify, 
        builder: (context, state) {
          final verificationId = state.extra as String? ?? authNotifier.verificationId ?? '';
          return OTPVerifyScreen(verificationId: verificationId);
        }
      ),
      GoRoute(path: AppRoutes.registration, builder: (context, state) => const RegistrationScreen()),
      GoRoute(path: AppRoutes.verificationPending, builder: (context, state) => const VerificationPendingScreen()),
      GoRoute(
        path: AppRoutes.notifications, 
        redirect: (context, state) {
          final authState = ref.read(authNotifierProvider);
          if (authState.isLoading) return null;
          if (authState.value == null) return AppRoutes.login;
          return null;
        },
        builder: (context, state) => const NotificationsScreen(),
      ),
      
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => MainScaffold(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.dashboard, 
              redirect: (context, state) {
                final authState = ref.read(authNotifierProvider);
                if (authState.isLoading) return null;
                if (authState.value == null) return AppRoutes.login;
                return null;
              },
              builder: (context, state) => const DashboardScreen(),
            )
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.bookings,
              redirect: (context, state) {
                final authState = ref.read(authNotifierProvider);
                if (authState.isLoading) return null;
                if (authState.value == null) return AppRoutes.login;
                return null;
              },
              builder: (context, state) => const BookingsScreen(),
              routes: [
                GoRoute(path: ':bookingId', builder: (context, state) => BookingDetailScreen(bookingId: state.pathParameters['bookingId']!)),
              ],
            )
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.services,
              redirect: (context, state) {
                final authState = ref.read(authNotifierProvider);
                if (authState.isLoading) return null;
                if (authState.value == null) return AppRoutes.login;
                return null;
              },
              builder: (context, state) => const MyServicesScreen(),
              routes: [
                GoRoute(path: 'add', builder: (context, state) => const AddServiceScreen()),
                GoRoute(path: 'edit/:serviceId', builder: (context, state) => AddServiceScreen(serviceId: state.pathParameters['serviceId'])),
              ],
            )
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.earnings,
              redirect: (context, state) {
                final authState = ref.read(authNotifierProvider);
                if (authState.isLoading) return null;
                if (authState.value == null) return AppRoutes.login;
                return null;
              },
              builder: (context, state) => const EarningsScreen(),
            )
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.profile,
              redirect: (context, state) {
                final authState = ref.read(authNotifierProvider);
                if (authState.isLoading) return null;
                if (authState.value == null) return AppRoutes.login;
                return null;
              },
              builder: (context, state) => const ProfileScreen(),
            )
          ]),
        ],
      ),
      GoRoute(
        path: AppRoutes.chat, 
        redirect: (context, state) {
          final authState = ref.read(authNotifierProvider);
          if (authState.isLoading) return null;
          if (authState.value == null) return AppRoutes.login;
          return null;
        },
        builder: (context, state) => ChatScreen(bookingId: state.pathParameters['bookingId']!, otherPartyName: 'Customer'),
      ),
      GoRoute(
        path: AppRoutes.withdrawal, 
        redirect: (context, state) {
          final authState = ref.read(authNotifierProvider);
          if (authState.isLoading) return null;
          if (authState.value == null) return AppRoutes.login;
          return null;
        },
        builder: (context, state) => const WithdrawalScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        redirect: (context, state) {
          final authState = ref.read(authNotifierProvider);
          if (authState.isLoading) return null;
          if (authState.value == null) return AppRoutes.login;
          return null;
        },
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
});

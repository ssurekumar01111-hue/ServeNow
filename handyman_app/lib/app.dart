import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/core/providers/theme_provider.dart';
import 'package:handyman/core/router/app_router.dart';
import 'package:handyman/core/router/app_routes.dart';
import 'package:handyman/core/theme/app_theme.dart';
import 'package:handyman/features/auth/presentation/providers/auth_provider.dart';
import 'package:handyman/features/notifications/data/notification_service.dart';
import 'package:handyman/core/widgets/offline_banner.dart';
import 'package:handyman/features/jobs/presentation/providers/jobs_providers.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();
    // Initialize notifications with navigation callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationService().init((type, id) {
        if (!mounted) return;
        final router = ref.read(routerProvider);
        if (type == 'booking_update' || type == 'booking_new' || type == 'booking_assigned') {
          // Handyman usually views job detail
          router.push('/job/$id'); // Assuming this is the route for job details
        } else if (type == 'chat') {
          router.push('/chat/$id');
        }
      });

      // Save FCM token when user is logged in
      ref.listenManual(authNotifierProvider, (previous, next) {
        final user = next.value;
        if (user != null) {
          NotificationService().saveToken(user.uid);
        }
      }, fireImmediately: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeModeAsync = ref.watch(themeModeProvider);
    final router = ref.watch(routerProvider);

    // Listen to auth changes and navigate manually
    ref.listen(authNotifierProvider, (previous, next) {
      if (next.isLoading) return;
      
      final isOtpSent = ref.read(authNotifierProvider.notifier).isOtpSent;
      if (isOtpSent) return; // Never redirect during OTP flow

      final wasLoggedIn = previous?.value != null;
      final isLoggedIn = next.value != null;
      final isNewUser = ref.read(authNotifierProvider.notifier).isNewUser;

      // Get current location from router
      final currentLocation = router.routerDelegate.currentConfiguration.uri.toString();
      debugPrint('🔄 Auth change listener: wasLoggedIn=$wasLoggedIn isLoggedIn=$isLoggedIn isOtpSent=$isOtpSent, location: $currentLocation');

      // Only navigate on actual transitions
      if (!wasLoggedIn && isLoggedIn) {
        // User just logged in
        if (isNewUser) {
          debugPrint('🔄 New user logged in — navigating to /sign-up');
          router.go(AppRoutes.signUp);
        } else {
          debugPrint('🔄 User logged in — navigating to /dashboard');
          router.go(AppRoutes.dashboard);
        }
      } else if (wasLoggedIn && !isLoggedIn) {
        // User just logged out
        // Only go to login if not already on an auth screen
        if (currentLocation != AppRoutes.login && 
            currentLocation != AppRoutes.otpVerify && 
            currentLocation != AppRoutes.splash) {
          debugPrint('🔄 User logged out — navigating to /login');
          router.go(AppRoutes.login);
        }
      }
    });

    return MaterialApp.router(
      title: 'ServeNow Pro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeModeAsync.value ?? ThemeMode.system,
      routerConfig: router,
      builder: (context, child) {
        return Column(
          children: [
            Expanded(child: child ?? const SizedBox.shrink()),
            const OfflineBanner(),
          ],
        );
      },
    );
  }
}

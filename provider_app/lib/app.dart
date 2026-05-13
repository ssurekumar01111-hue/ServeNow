import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/core/providers/theme_provider.dart';
import 'package:provider/core/router/app_router.dart';
import 'package:provider/core/router/app_routes.dart';
import 'package:provider/core/theme/app_theme.dart';
import 'package:provider/features/auth/domain/entities/user_entity.dart';
import 'package:provider/features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/features/notifications/data/notification_service.dart';
import 'package:provider/core/widgets/offline_banner.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();
    // Save FCM token when user is logged in
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
    ref.listen<AsyncValue<UserEntity?>>(authNotifierProvider, (previous, next) async {
      if (next.isLoading) return;
      
      final isOtpSent = ref.read(authNotifierProvider.notifier).isOtpSent;
      if (isOtpSent) return; // Never redirect during OTP flow

      final wasLoggedIn = previous?.value != null;
      final isLoggedIn = next.value != null;
      if (next.hasError) return;

      // Get current location from router
      final currentLocation = router.routerDelegate.currentConfiguration.uri.toString();
      debugPrint('🔄 Auth change listener: wasLoggedIn=$wasLoggedIn isLoggedIn=$isLoggedIn isOtpSent=$isOtpSent, location: $currentLocation');

      // Only navigate on actual transitions
      if (!wasLoggedIn && isLoggedIn) {
        // New login — check registration status
        final uid = next.value!.uid;
        final providerDoc = await FirebaseFirestore.instance.collection('providers').doc(uid).get();

        if (!providerDoc.exists) {
          router.go(AppRoutes.registration);
        } else {
          final isApproved = providerDoc.data()?['isApproved'] as bool? ?? false;
          if (!isApproved) {
            router.go(AppRoutes.verificationPending);
          } else {
            router.go(AppRoutes.dashboard);
          }
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
      title: 'ServeNow Provider',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeModeAsync.value ?? ThemeMode.system,
      routerConfig: router,
      builder: (context, child) {
        return Stack(
          children: [
            child ?? const SizedBox.shrink(),
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: OfflineBanner(),
            ),
          ],
        );
      },
    );
  }
}

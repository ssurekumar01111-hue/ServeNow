import 'package:customer/core/constants/booking_status.dart';
import 'package:customer/core/providers/theme_provider.dart';
import 'package:customer/core/router/app_router.dart';
import 'package:customer/core/router/app_routes.dart';
import 'package:customer/core/theme/app_theme.dart';
import 'package:customer/features/auth/domain/entities/user_entity.dart';
import 'package:customer/features/auth/presentation/providers/auth_provider.dart';
import 'package:customer/features/booking/domain/entities/booking_entity.dart';
import 'package:customer/features/booking/presentation/providers/booking_providers.dart';
import 'package:customer/features/notifications/data/notification_service.dart';
import 'package:customer/features/reviews/presentation/widgets/rate_service_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:customer/core/widgets/offline_banner.dart';
import 'package:flutter/foundation.dart';

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
        if (type == 'booking_update' || type == 'booking_new') {
          router.push(AppRoutes.bookingDetailPath(id));
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
    ref.listen<AsyncValue<UserEntity?>>(authNotifierProvider, (previous, next) {
      if (next.isLoading) return;
      
      final isOtpSent = ref.read(authNotifierProvider.notifier).isOtpSent;
      if (isOtpSent) return; // Never redirect during OTP flow

      final wasLoggedIn = previous?.value != null;
      final isLoggedIn = next.value != null;

      // Get current location from router
      final currentLocation = router.routerDelegate.currentConfiguration.uri.toString();
      if (kDebugMode) {
        debugPrint('🔄 Auth change listener: wasLoggedIn=$wasLoggedIn isLoggedIn=$isLoggedIn isOtpSent=$isOtpSent, location: $currentLocation');
      }

      // Only navigate on actual transitions
      if (!wasLoggedIn && isLoggedIn) {
        // User just logged in
        if (kDebugMode) {
          debugPrint('🔄 User logged in — navigating to /home');
        }
        router.go(AppRoutes.home);
      } else if (wasLoggedIn && !isLoggedIn) {
        // User just logged out
        // Only go to login if not already on an auth screen
        if (currentLocation != AppRoutes.login && 
            currentLocation != AppRoutes.otp && 
            currentLocation != AppRoutes.onboarding &&
            currentLocation != AppRoutes.splash) {
          if (kDebugMode) {
            debugPrint('🔄 User logged out — navigating to /login');
          }
          router.go(AppRoutes.login);
        }
      }
    });

    return MaterialApp.router(
      title: 'ServeNow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeModeAsync.value ?? ThemeMode.system,
      routerConfig: router,
      builder: (context, child) {
        if (child == null) return const SizedBox.shrink();
        return Scaffold(
          body: Stack(
            children: [
              RateTriggerWrapper(
                child: child,
              ),
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: OfflineBanner(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class RateTriggerWrapper extends ConsumerStatefulWidget {
  const RateTriggerWrapper({required this.child, super.key});
  final Widget child;

  @override
  ConsumerState<RateTriggerWrapper> createState() => _RateTriggerWrapperState();
}

class _RateTriggerWrapperState extends ConsumerState<RateTriggerWrapper> {
  final Set<String> _notifiedBookings = {};

  @override
  Widget build(BuildContext context) {
    // Listen to completed bookings for rating trigger
    ref.listen<AsyncValue<List<BookingEntity>>>(myBookingsProvider, (prev, next) {
      final bookings = next.value;
      if (bookings != null) {
        for (final booking in bookings) {
          if (booking.status == BookingStatuses.completed && 
              !booking.isRated && 
              !_notifiedBookings.contains(booking.id)) {
            _notifiedBookings.add(booking.id);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                // Use the context of the child (which is the Navigator's content)
                // Actually, builder context is above Navigator.
                // We need a context that has Navigator.
                // One way is to use a GlobalKey for Navigator or a nested Builder.
                // But let's try using the context from the child if it's possible, 
                // or just use router.routerDelegate to get context if available.
                // For now, let's use a simpler approach: check if Navigator can find it.
                try {
                  RateServiceBottomSheet.show(context, booking);
                } catch (e) {
                  if (kDebugMode) {
                    debugPrint('Error showing rating bottom sheet: $e');
                  }
                }
              }
            });
          }
        }
      }
    });

    return widget.child;
  }
}

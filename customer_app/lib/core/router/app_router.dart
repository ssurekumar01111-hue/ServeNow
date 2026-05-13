import 'package:customer/core/router/app_routes.dart';
import 'package:customer/features/auth/presentation/providers/auth_provider.dart';
import 'package:customer/features/auth/presentation/screens/welcome_screen.dart';
import 'package:customer/features/auth/presentation/screens/blocked_screen.dart';
import 'package:customer/features/auth/presentation/screens/customer_onboarding_screen.dart';
import 'package:customer/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:customer/features/auth/presentation/screens/otp_verify_screen.dart';
import 'package:customer/features/auth/presentation/screens/phone_login_screen.dart';
import 'package:customer/features/auth/presentation/screens/splash_screen.dart';
import 'package:customer/features/booking/presentation/providers/booking_form_state.dart';
import 'package:customer/features/booking/presentation/screens/booking_confirmation_screen.dart';
import 'package:customer/features/booking/presentation/screens/booking_detail_screen.dart';
import 'package:customer/features/booking/presentation/screens/tracking_screen.dart';
import 'package:customer/features/chat/presentation/screens/chat_screen.dart';
import 'package:customer/features/booking/presentation/screens/booking_form_screen.dart';
import 'package:customer/features/booking/presentation/screens/checkout_screen.dart';
import 'package:customer/features/booking/presentation/screens/coupon_screen.dart';
import 'package:customer/features/booking/presentation/screens/my_bookings_screen.dart';
import 'package:customer/features/home/presentation/screens/all_categories_screen.dart';
import 'package:customer/features/home/presentation/screens/all_providers_screen.dart';
import 'package:customer/features/services/presentation/screens/all_services_screen.dart';
import 'package:customer/features/home/presentation/screens/home_screen.dart';
import 'package:customer/features/home/presentation/screens/main_screen.dart';
import 'package:customer/features/notifications/presentation/notifications_screen.dart';
import 'package:customer/features/referral/presentation/refer_earn_screen.dart';
import 'package:customer/features/reviews/presentation/rate_review_screen.dart';
import 'package:customer/features/services/domain/entities/service_entity.dart';
import 'package:customer/features/services/presentation/screens/category_services_screen.dart';
import 'package:customer/features/services/presentation/screens/provider_profile_screen.dart';
import 'package:customer/features/services/presentation/screens/service_detail_screen.dart';
import 'package:customer/features/wallet/presentation/wallet_screen.dart';
import 'package:customer/features/profile/presentation/screens/profile_screen.dart';
import 'package:customer/features/profile/presentation/screens/settings_screen.dart';
import 'package:customer/features/profile/presentation/screens/saved_addresses_screen.dart';
import 'package:customer/features/profile/presentation/screens/add_address_screen.dart';
import 'package:customer/features/support/presentation/screens/help_support_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authNotifier = ref.watch(authNotifierProvider.notifier);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    onException: (context, state, router) {
      debugPrint('🚨 GoRouter exception: ${state.error}');
      debugPrint('🚨 Attempted path: ${state.uri}');
    },
    // No global redirect - handled by app.dart listener and route-level redirects
    routes: [
      GoRoute(
        path: '/',
        redirect: (_, __) => AppRoutes.splash,
      ),
      GoRoute(path: AppRoutes.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: AppRoutes.welcome, builder: (context, state) => const WelcomeScreen()),
      GoRoute(path: AppRoutes.onboarding, builder: (context, state) => const CustomerOnboardingScreen()),
      GoRoute(path: '/tutorial', builder: (context, state) => const TutorialScreen()),
      GoRoute(path: AppRoutes.blocked, builder: (context, state) => const BlockedScreen()),
      GoRoute(path: AppRoutes.login, builder: (context, state) => const PhoneLoginScreen()),
      GoRoute(
        path: AppRoutes.otp,
        builder: (context, state) {
          final verificationId = state.extra as String? ?? authNotifier.verificationId ?? '';
          return OTPVerifyScreen(verificationId: verificationId);
        },
      ),
      ShellRoute(
        builder: (context, state, child) => MainScreen(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            redirect: (context, state) {
              final authState = ref.read(authNotifierProvider);
              if (authState.isLoading) return null;
              if (authState.value == null) return AppRoutes.login;
              return null;
            },
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.myBookings,
            name: 'myBookings',
            redirect: (context, state) {
              final authState = ref.read(authNotifierProvider);
              if (authState.isLoading) return null;
              if (authState.value == null) return AppRoutes.login;
              return null;
            },
            builder: (context, state) => const MyBookingsScreen(),
          ),
          GoRoute(
            path: AppRoutes.wallet,
            redirect: (context, state) {
              final authState = ref.read(authNotifierProvider);
              if (authState.isLoading) return null;
              if (authState.value == null) return AppRoutes.login;
              return null;
            },
            builder: (context, state) => const WalletScreen(),
          ),
          GoRoute(
            path: AppRoutes.profile,
            redirect: (context, state) {
              final authState = ref.read(authNotifierProvider);
              if (authState.isLoading) return null;
              if (authState.value == null) return AppRoutes.login;
              return null;
            },
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.categoryServices,
        builder: (context, state) {
          final id = state.pathParameters['categoryId']!;
          final name = state.extra! as String;
          return CategoryServicesScreen(categoryId: id, categoryName: name);
        },
      ),
      GoRoute(
        path: AppRoutes.serviceDetail,
        builder: (context, state) {
          final id = state.pathParameters['serviceId']!;
          return ServiceDetailScreen(serviceId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.providerProfile,
        builder: (context, state) {
          final id = state.pathParameters['providerId']!;
          return ProviderProfileScreen(providerId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.bookingForm,
        name: 'bookingForm',
        redirect: (context, state) {
          final authState = ref.read(authNotifierProvider);
          if (authState.isLoading) return null;
          if (authState.value == null) return AppRoutes.login;
          return null;
        },
        builder: (context, state) {
          final service = state.extra as ServiceEntity?;
          return BookingFormScreen(service: service);
        },
      ),
      GoRoute(
        path: AppRoutes.checkout,
        name: 'checkout',
        redirect: (context, state) {
          final authState = ref.read(authNotifierProvider);
          if (authState.isLoading) return null;
          if (authState.value == null) return AppRoutes.login;
          return null;
        },
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final booking = extra?['booking'] as BookingFormState?;
          final service = extra?['service'] as ServiceEntity?;
          return CheckoutScreen(bookingData: booking, service: service);
        },
      ),
      GoRoute(
        path: AppRoutes.bookingConfirmation,
        name: 'bookingConfirmation',
        redirect: (context, state) {
          final authState = ref.read(authNotifierProvider);
          if (authState.isLoading) return null;
          if (authState.value == null) return AppRoutes.login;
          return null;
        },
        builder: (context, state) {
          return const BookingConfirmationScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.bookingDetail,
        name: 'bookingDetail',
        redirect: (context, state) {
          final authState = ref.read(authNotifierProvider);
          if (authState.isLoading) return null;
          if (authState.value == null) return AppRoutes.login;
          return null;
        },
        builder: (context, state) {
          final bookingId = state.pathParameters['bookingId']!;
          return BookingDetailScreen(bookingId: bookingId);
        },
      ),
      GoRoute(
        path: AppRoutes.liveTracking,
        name: 'liveTracking',
        redirect: (context, state) {
          final authState = ref.read(authNotifierProvider);
          if (authState.isLoading) return null;
          if (authState.value == null) return AppRoutes.login;
          return null;
        },
        builder: (context, state) {
          final bookingId = state.pathParameters['bookingId']!;
          return TrackingScreen(bookingId: bookingId);
        },
      ),
      GoRoute(
        path: AppRoutes.chat,
        name: 'chat',
        redirect: (context, state) {
          final authState = ref.read(authNotifierProvider);
          if (authState.isLoading) return null;
          if (authState.value == null) return AppRoutes.login;
          return null;
        },
        builder: (context, state) {
          final bookingId = state.pathParameters['bookingId']!;
          return ChatScreen(bookingId: bookingId, otherName: 'Handyman');
        },
      ),
      GoRoute(
        path: AppRoutes.coupon,
        redirect: (context, state) {
          final authState = ref.read(authNotifierProvider);
          if (authState.isLoading) return null;
          if (authState.value == null) return AppRoutes.login;
          return null;
        },
        builder: (context, state) => const CouponScreen(),
      ),
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
      GoRoute(
        path: AppRoutes.referral,
        redirect: (context, state) {
          final authState = ref.read(authNotifierProvider);
          if (authState.isLoading) return null;
          if (authState.value == null) return AppRoutes.login;
          return null;
        },
        builder: (context, state) => const ReferEarnScreen(),
      ),
      GoRoute(
        path: AppRoutes.rateReview,
        redirect: (context, state) {
          final authState = ref.read(authNotifierProvider);
          if (authState.isLoading) return null;
          if (authState.value == null) return AppRoutes.login;
          return null;
        },
        builder: (context, state) {
          final bookingId = state.pathParameters['bookingId']!;
          final providerId = state.pathParameters['providerId']!;
          return RateReviewScreen(bookingId: bookingId, providerId: providerId);
        },
      ),
      GoRoute(path: AppRoutes.allCategories, builder: (context, state) => const AllCategoriesScreen()),
      GoRoute(path: AppRoutes.allProviders, builder: (context, state) => const AllProvidersScreen()),
      GoRoute(path: AppRoutes.allServices, builder: (context, state) => const AllServicesScreen()),
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
      GoRoute(
        path: AppRoutes.savedAddresses,
        redirect: (context, state) {
          final authState = ref.read(authNotifierProvider);
          if (authState.isLoading) return null;
          if (authState.value == null) return AppRoutes.login;
          return null;
        },
        builder: (context, state) => const SavedAddressesScreen(),
      ),
      GoRoute(
        path: AppRoutes.addAddress,
        redirect: (context, state) {
          final authState = ref.read(authNotifierProvider);
          if (authState.isLoading) return null;
          if (authState.value == null) return AppRoutes.login;
          return null;
        },
        builder: (context, state) => const AddAddressScreen(),
      ),
      GoRoute(
        path: AppRoutes.support,
        redirect: (context, state) {
          final authState = ref.read(authNotifierProvider);
          if (authState.isLoading) return null;
          if (authState.value == null) return AppRoutes.login;
          return null;
        },
        builder: (context, state) => const HelpSupportScreen(),
      ),
    ],
  );
});

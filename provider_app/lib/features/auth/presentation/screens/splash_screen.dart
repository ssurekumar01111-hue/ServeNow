import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/core/router/app_routes.dart';
import 'package:provider/core/theme/app_colors.dart';
import 'package:provider/features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/features/profile/domain/entities/provider_profile_entity.dart';
import 'package:provider/features/profile/presentation/providers/profile_providers.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6, curve: Curves.elasticOut)),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 1.0, curve: Curves.easeIn)),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 1.0, curve: Curves.easeOut)),
    );
    _controller.forward();

    // Navigate after animation and auth check
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) _checkAuthAndNavigate();
    });
  }

  void _checkAuthAndNavigate() {
    if (_hasNavigated) return;

    final authState = ref.read(authNotifierProvider);

    authState.when(
      data: (user) {
        if (_hasNavigated) return;

        if (user == null) {
          _hasNavigated = true;
          context.go(AppRoutes.login);
          return;
        }

        final profileAsync = ref.read(providerProfileProvider);
        profileAsync.when(
          data: (profile) {
            if (_hasNavigated) return;

            if (profile == null) {
              // Create initial provider document
              final user = ref.read(authNotifierProvider).value!;
              final newProfile = ProviderProfileEntity(
                id: user.uid,
                uid: user.uid,
                email: user.email ?? '',
                phone: user.phone ?? '',
                businessName: '',
                categories: [],
                serviceArea: '',
                commissionRate: 10.0,
                onboardingStatus: 'pending_profile',
                isActive: false,
                rating: 0.0,
                totalRatings: 0,
                totalBookings: 0,
                totalEarnings: 0.0,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
                description: '',
                businessLicenseUrl: '',
              );

              ref
                  .read(providerProfileProvider.notifier)
                  .updateProfile(newProfile)
                  .then((_) {
                if (mounted && !_hasNavigated) {
                  _hasNavigated = true;
                  context.go(AppRoutes.registration);
                }
              });
              return;
            }

            _hasNavigated = true;
            switch (profile.onboardingStatus) {
              case 'pending_profile':
                context.go(AppRoutes.registration);
                break;
              case 'pending_approval':
              case 'rejected':
                context.go(AppRoutes.verificationPending);
                break;
              case 'approved':
                context.go(AppRoutes.dashboard);
                break;
              default:
                context.go(AppRoutes.registration);
            }
          },
          loading: () {
            // Profile still loading, retry after delay
            Future.delayed(const Duration(milliseconds: 500), () {
              if (mounted && !_hasNavigated) _checkAuthAndNavigate();
            });
          },
          error: (e, st) {
            // Profile error, retry
            Future.delayed(const Duration(milliseconds: 500), () {
              if (mounted && !_hasNavigated) _checkAuthAndNavigate();
            });
          },
        );
      },
      loading: () {
        // Auth still loading, retry after delay
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted && !_hasNavigated) _checkAuthAndNavigate();
        });
      },
      error: (e, st) {
        if (_hasNavigated) return;
        _hasNavigated = true;
        context.go(AppRoutes.login);
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // Full width — critical
        height: double.infinity, // Full height — critical
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
            children: [
              const Spacer(),

              // Animated logo
              ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4A6CF7).withOpacity(0.4),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.home_repair_service_rounded,
                    color: Color(0xFF4A6CF7),
                    size: 52,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // App name — must be centered
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Main title
                      const Text(
                        'ServeNow',
                        textAlign: TextAlign.center, // Center text
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          letterSpacing: 1,
                        ),
                      ),
                      // Provider badge
                      Container(
                        margin: const EdgeInsets.only(top: 6),
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4A6CF7).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: const Color(0xFF4A6CF7).withOpacity(0.5)),
                        ),
                        child: const Text(
                          'PROVIDER',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            letterSpacing: 3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Tagline
                      Text(
                        'Grow Your Service Business',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Loading indicator at bottom
              FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 48),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 36,
                        height: 36,
                        child: CircularProgressIndicator(
                          color: Colors.white.withOpacity(0.7),
                          strokeWidth: 2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Loading...',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

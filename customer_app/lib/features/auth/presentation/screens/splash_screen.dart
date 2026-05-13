import 'package:customer/core/router/app_routes.dart';
import 'package:customer/core/theme/app_colors.dart';
import 'package:customer/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
  bool _hasNavigated = false; // Guard flag to prevent double navigation

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
    if (_hasNavigated) return; // Never navigate twice
    
    final authState = ref.read(authNotifierProvider);
    if (kDebugMode) {
      debugPrint('🌊 Splash navigating, auth: ${authState.value}');
    }

    authState.when(
      data: (user) {
        if (_hasNavigated) return;
        _hasNavigated = true;
        if (kDebugMode) {
          debugPrint('🌊 Splash: user=$user, navigating...');
        }
        if (user != null) {
          if (user.isBlocked == true) {
            context.go(AppRoutes.blocked);
          } else if (user.isProfileComplete != true) {
            context.go(AppRoutes.onboarding);
          } else {
            context.go(AppRoutes.home);
          }
        } else {
          context.go(AppRoutes.welcome);
        }
      },
      loading: () {
        // Wait for auth to resolve — retry after delay
        if (kDebugMode) {
          debugPrint('🌊 Splash: Auth still loading, retrying in 500ms...');
        }
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted && !_hasNavigated) _checkAuthAndNavigate();
        });
      },
      error: (e, st) {
        if (_hasNavigated) return;
        _hasNavigated = true;
        if (kDebugMode) {
          debugPrint('🌊 Splash: Auth error ($e), going to welcome');
        }
        context.go(AppRoutes.welcome);
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.splashGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                          color: AppColors.primary.withOpacity(0.4),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.home_repair_service_rounded, color: AppColors.primary, size: 52),
                  ),
                ),
                const SizedBox(height: 24),
                // Animated app name
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      children: [
                        const Text(
                          'ServeNow',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Home Services at Your Doorstep',
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
                const SizedBox(height: 80),
                // Loading indicator
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      color: Colors.white.withOpacity(0.7),
                      strokeWidth: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

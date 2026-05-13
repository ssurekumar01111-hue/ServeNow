import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/core/router/app_router.dart';
import 'package:handyman/core/router/app_routes.dart';
import 'package:handyman/core/services/location_service.dart';
import 'package:handyman/core/theme/app_colors.dart';
import 'package:handyman/features/auth/presentation/providers/auth_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    // Wait for splash animation
    await Future.delayed(const Duration(milliseconds: 2500));
    
    if (!mounted || _hasNavigated) return;

    final authState = ref.read(authNotifierProvider);
    
    if (authState.isLoading) {
      // If still loading, wait a bit more
      await Future.delayed(const Duration(milliseconds: 500));
      return _navigateToNext();
    }

    _hasNavigated = true;

    // Request location permission
    final permissionGranted = await LocationService.requestLocationPermission();
    if (!permissionGranted && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location access is needed to receive and manage jobs.'),
          duration: Duration(seconds: 4),
        ),
      );
    }

    final user = authState.value;
    final router = ref.read(routerProvider);

    if (user == null) {
      if (mounted) router.go(AppRoutes.login);
    } else {
      // Check if registration is complete
      final isNewUser = ref.read(authNotifierProvider.notifier).isNewUser;
      if (isNewUser) {
        if (mounted) router.go(AppRoutes.signUp);
      } else {
        if (mounted) router.go(AppRoutes.dashboard);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // We use Navigator.of(context).pushReplacementNamed because GoRouter 
    // might not be fully ready or we want to avoid double navigation 
    // if the auth listener in app.dart also triggers.
    // Actually, app.dart listener should handle it if we just wait.
    // But manual navigation in splash is safer for the initial transition.

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.splashGradient,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 800),
              child: ZoomIn(
                duration: const Duration(milliseconds: 1000),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.2), width: 2),
                  ),
                  child: const Icon(
                    Icons.build_circle_rounded, // Handyman icon
                    size: 100,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            FadeInUp(
              duration: const Duration(milliseconds: 800),
              delay: const Duration(milliseconds: 400),
              child: const Text(
                'ServeNow Pro',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 8),
            FadeIn(
              duration: const Duration(milliseconds: 1000),
              delay: const Duration(milliseconds: 800),
              child: Text(
                'Complete Jobs, Earn More',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 60),
            FadeIn(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 1500),
              child: const SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

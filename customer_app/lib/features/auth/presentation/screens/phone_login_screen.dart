import 'package:customer/core/router/app_routes.dart';
import 'package:customer/core/theme/app_colors.dart';
import 'package:customer/core/widgets/cached_image_widget.dart';
import 'package:customer/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PhoneLoginScreen extends ConsumerStatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  ConsumerState<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends ConsumerState<PhoneLoginScreen> {
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);
    try {
      await ref.read(authNotifierProvider.notifier).signInWithGoogle();
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: AppColors.error),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.splashGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60),
                // Logo
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.home_repair_service_rounded, color: AppColors.primary, size: 40),
                ),
                const SizedBox(height: 40),
                // Login Card
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome Back',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Enter your mobile number to continue',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 32),
                      TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.5,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 16, right: 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  '+91',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(height: 20, width: 1, color: Colors.grey),
                              ],
                            ),
                          ),
                          hintText: '00000 00000',
                          counterText: '',
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: AppColors.primaryGradient,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () async {
                                  if (_phoneController.text.trim().length != 10) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Enter a valid 10 digit number')),
                                    );
                                    return;
                                  }
                                  setState(() => _isLoading = true);
                                  final phone = '+91${_phoneController.text.trim()}';

                                  // Use a completer to wait for codeSent callback
                                  bool navigated = false;

                                  // Listen before sending
                                  final subscription = ref.listenManual(authNotifierProvider, (previous, next) {
                                    if (!navigated && !next.isLoading && !next.hasError) {
                                      final isOtpSent = ref.read(authNotifierProvider.notifier).isOtpSent;
                                      debugPrint('🚀 Manual listener fired, isOtpSent: $isOtpSent');
                                      if (isOtpSent && context.mounted) {
                                        navigated = true;
                                        setState(() => _isLoading = false);
                                        context.push(AppRoutes.otp);
                                      }
                                    }
                                    if (next.hasError) {
                                      setState(() => _isLoading = false);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(next.error.toString())),
                                      );
                                    }
                                  });

                                  await ref.read(authNotifierProvider.notifier).sendOTP(phone);

                                  // Safety fallback — if codeSent already fired before listener was set up
                                  await Future.delayed(const Duration(milliseconds: 500));
                                  if (!navigated && ref.read(authNotifierProvider.notifier).isOtpSent && context.mounted) {
                                    navigated = true;
                                    setState(() => _isLoading = false);
                                    debugPrint('🚀 Fallback navigation to ${AppRoutes.otp}');
                                    context.push(AppRoutes.otp);
                                  }

                                  // Cancel subscription after navigation
                                  Future.delayed(const Duration(seconds: 65), () => subscription.close());
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                )
                              : const Text(
                                  'Send OTP',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('OR', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(height: 32),
                      OutlinedButton(
                        onPressed: _isLoading ? null : _signInWithGoogle,
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ServiceImageWidget(
                              imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_\"G\"_logo.svg/1200px-Google_\"G\"_logo.svg.png',
                              width: 20,
                              height: 20,
                              placeholderIcon: Icons.login,
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Continue with Google',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'By continuing, you agree to our Terms of Service and Privacy Policy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


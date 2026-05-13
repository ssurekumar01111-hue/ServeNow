import 'dart:async';
import 'package:customer/core/router/app_routes.dart';
import 'package:customer/core/theme/app_colors.dart';
import 'package:customer/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class OTPVerifyScreen extends ConsumerStatefulWidget {
  const OTPVerifyScreen({required this.verificationId, super.key});
  final String verificationId;

  @override
  ConsumerState<OTPVerifyScreen> createState() => _OTPVerifyScreenState();
}

class _OTPVerifyScreenState extends ConsumerState<OTPVerifyScreen> {
  final _pinController = TextEditingController();
  final _focusNode = FocusNode();
  int _timerCount = 30;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authNotifierProvider.notifier).resetOtpSentFlag();
    });
  }

  void _startTimer() {
    _timerCount = 30;
    _canResend = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerCount == 0) {
        setState(() {
          _canResend = true;
          _timer?.cancel();
        });
      } else {
        setState(() {
          _timerCount--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _verifyOTP() async {
    final code = _pinController.text.trim();
    if (code.length == 6) {
      final verificationId = ref.read(authNotifierProvider.notifier).verificationId ?? widget.verificationId;
      await ref.read(authNotifierProvider.notifier).verifyOTP(verificationId, code);
      
      final authState = ref.read(authNotifierProvider);
      if (authState.hasValue && authState.value != null && context.mounted) {
        final user = authState.value!;
        if (user.isBlocked == true) {
          context.go(AppRoutes.blocked);
        } else if (user.isProfileComplete == true) {
          context.go(AppRoutes.home);
        } else {
          context.go(AppRoutes.onboarding);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Verify your number',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Enter the 6-digit code sent to your phone',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 48),
            Center(
              child: Pinput(
                length: 6,
                controller: _pinController,
                focusNode: _focusNode,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: AppColors.primary, width: 1.5),
                  ),
                ),
                onCompleted: (pin) => _verifyOTP(),
              ),
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: authState.isLoading ? null : _verifyOTP,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: authState.isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : const Text(
                        'Verify',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: _canResend
                  ? TextButton(
                      onPressed: () {
                        // Resend logic - would need phone number from previous screen
                        // For now we just reset timer to simulate
                        _startTimer();
                      },
                      child: const Text(
                        'Resend OTP',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : Text(
                      'Resend in 0:${_timerCount.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

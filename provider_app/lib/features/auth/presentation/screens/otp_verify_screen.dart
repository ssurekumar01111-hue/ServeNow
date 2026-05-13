import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/features/auth/presentation/providers/auth_provider.dart';

class OTPVerifyScreen extends ConsumerStatefulWidget {
  const OTPVerifyScreen({required this.verificationId, super.key});
  final String verificationId;

  @override
  ConsumerState<OTPVerifyScreen> createState() => _OTPVerifyScreenState();
}

class _OTPVerifyScreenState extends ConsumerState<OTPVerifyScreen> {
  final _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authNotifierProvider.notifier).resetOtpSentFlag();
    });
  }

  void _verifyOTP() {
    final code = _otpController.text.trim();
    if (code.length == 6) {
      final verificationId = ref.read(authNotifierProvider.notifier).verificationId ?? widget.verificationId;
      ref.read(authNotifierProvider.notifier).verifyOTP(verificationId, code);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text('Enter the 6-digit code sent to your phone'),
            const SizedBox(height: 24),
            TextField(
              controller: _otpController,
              decoration: const InputDecoration(labelText: 'OTP'),
              keyboardType: TextInputType.number,
              maxLength: 6,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: authState.isLoading ? null : _verifyOTP,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: authState.isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  )
                : const Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}

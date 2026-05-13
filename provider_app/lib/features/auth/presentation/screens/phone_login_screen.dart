import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/features/auth/domain/entities/user_entity.dart';
import 'package:provider/features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/features/auth/presentation/widgets/social_login_button.dart';

class PhoneLoginScreen extends ConsumerStatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  ConsumerState<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends ConsumerState<PhoneLoginScreen> {
  final _phoneController = TextEditingController();

  Future<void> _sendOTP() async {
    String phoneNumber = _phoneController.text.trim();
    
    // Validate length
    if (phoneNumber.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 10 digit mobile number')),
      );
      return;
    }

    final phoneWithCode = '+91$phoneNumber';
    await ref.read(authNotifierProvider.notifier).sendOTP(phoneWithCode);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    ref.listen<AsyncValue<UserEntity?>>(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        },
      );
      
      if (ref.read(authNotifierProvider.notifier).isOtpSent) {
        context.push('/otp-verify');
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: const InputDecoration(
                prefixText: '+91 ',
                prefixStyle: TextStyle(fontWeight: FontWeight.bold),
                hintText: 'Enter 10 digit mobile number',
                counterText: '',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: authState.isLoading ? null : _sendOTP,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: authState.isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  )
                : const Text('Send OTP'),
            ),
            const Spacer(),
            const SocialLoginButton(),
          ],
        ),
      ),
    );
  }
}

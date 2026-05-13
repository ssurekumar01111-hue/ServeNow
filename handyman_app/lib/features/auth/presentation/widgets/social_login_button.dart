import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/features/auth/presentation/providers/auth_provider.dart';

class SocialLoginButton extends ConsumerWidget {
  const SocialLoginButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton.icon(
      onPressed: () => ref.read(authNotifierProvider.notifier).signInWithGoogle(),
      icon: const Icon(Icons.login), // Replace with Google icon
      label: const Text('Sign in with Google'),
    );
  }
}

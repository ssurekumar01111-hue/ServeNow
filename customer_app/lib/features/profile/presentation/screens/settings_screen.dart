import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/providers/theme_provider.dart';
import 'package:customer/core/router/app_routes.dart';
import 'package:customer/features/auth/presentation/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider).value ?? ThemeMode.system;
    final user = ref.watch(authNotifierProvider).value;

    // We'll use a local stream for notificationsEnabled since it might not be in UserEntity natively, or we can just fetch it.
    // For simplicity, we use a boolean that toggles Firestore.
    
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Theme'),
            trailing: DropdownButton<ThemeMode>(
              value: themeMode,
              items: const [
                DropdownMenuItem(value: ThemeMode.system, child: Text('System')),
                DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
                DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
              ],
              onChanged: (mode) {
                if (mode != null) {
                  ref.read(themeModeProvider.notifier).setThemeMode(mode);
                }
              },
            ),
          ),
          const Divider(),
          if (user != null)
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),
              builder: (context, snapshot) {
                final data = snapshot.data?.data() as Map<String, dynamic>?;
                final bool notificationsEnabled = data?['notificationsEnabled'] as bool? ?? true;
                return SwitchListTile(
                  title: const Text('Enable Notifications'),
                  value: notificationsEnabled,
                  onChanged: (val) {
                    FirebaseFirestore.instance.collection('users').doc(user.uid).update({'notificationsEnabled': val});
                  },
                );
              },
            ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                    TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Logout')),
                  ],
                ),
              );
              if (confirm == true) {
                await ref.read(authNotifierProvider.notifier).signOut();
                if (context.mounted) context.go(AppRoutes.login);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text('Delete Account', style: TextStyle(color: Colors.red)),
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Delete Account'),
                  content: const Text('This action is irreversible. All your data will be permanently deleted. Continue?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, true), 
                      child: const Text('Delete', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
              if (confirm == true && user != null) {
                try {
                  await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();
                  await FirebaseAuth.instance.currentUser?.delete();
                  ref.invalidate(authNotifierProvider);
                  if (context.mounted) context.go(AppRoutes.login);
                } catch (e) {
                  if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                }
              }
            },
          ),
        ],
      ),
    );
  }
}

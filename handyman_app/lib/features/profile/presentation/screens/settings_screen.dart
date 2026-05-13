import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/core/providers/theme_provider.dart';
import 'package:handyman/core/theme/app_colors.dart';
import 'package:handyman/features/auth/presentation/providers/auth_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeAsync = ref.watch(themeModeProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSectionHeader('Appearance'),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.dark_mode_outlined, color: AppColors.primary),
                  title: const Text('Dark Mode'),
                  subtitle: const Text('Adjust app theme'),
                  trailing: themeModeAsync.when(
                    data: (mode) => DropdownButton<ThemeMode>(
                      value: mode,
                      onChanged: (newMode) {
                        if (newMode != null) {
                          ref.read(themeModeProvider.notifier).setThemeMode(newMode);
                        }
                      },
                      items: const [
                        DropdownMenuItem(value: ThemeMode.system, child: Text('System')),
                        DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
                        DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
                      ],
                    ),
                    loading: () => const CircularProgressIndicator(),
                    error: (_, __) => const Icon(Icons.error),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Notifications'),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.notifications_active_outlined, color: AppColors.primary),
                  title: const Text('Job Alerts'),
                  subtitle: const Text('Get notified for new jobs'),
                  value: true,
                  activeColor: AppColors.primary,
                  onChanged: (v) {},
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.message_outlined, color: AppColors.primary),
                  title: const Text('Chat Notifications'),
                  subtitle: const Text('Real-time message alerts'),
                  value: true,
                  activeColor: AppColors.primary,
                  onChanged: (v) {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Account'),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.help_outline, color: AppColors.primary),
                  title: const Text('Support'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.info_outline, color: AppColors.primary),
                  title: const Text('About ServeNow Pro'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.logout, color: AppColors.error),
                  title: const Text('Logout', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
                  onTap: () {
                    _showLogoutDialog(context, ref);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.textSecondary,
          letterSpacing: 1,
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(authNotifierProvider.notifier).signOut();
            },
            child: const Text('Logout', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}

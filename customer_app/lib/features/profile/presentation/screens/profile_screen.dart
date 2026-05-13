import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/router/app_routes.dart';
import 'package:customer/core/theme/app_colors.dart';
import 'package:customer/core/widgets/cached_image_widget.dart';
import 'package:customer/features/auth/presentation/providers/auth_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final user = ref.read(authNotifierProvider).value;
    if (user != null) {
      _nameController.text = user.fullName ?? '';
      _emailController.text = user.email ?? '';
    }
  }

  Future<void> _pickAndUploadImage() async {
    final user = ref.read(authNotifierProvider).value;
    if (user == null) return;

    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    
    if (image != null) {
      setState(() => _isLoading = true);
      try {
        final refStorage = FirebaseStorage.instance.ref().child('customers/${user.uid}/profile.jpg');
        await refStorage.putFile(File(image.path));
        final url = await refStorage.getDownloadURL();
        
        await FirebaseFirestore.instance.collection('customers').doc(user.uid).update({'photoUrl': url});
        
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile photo updated')));
      } catch (e) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating photo: $e')));
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _saveProfile() async {
    final user = ref.read(authNotifierProvider).value;
    if (user == null) return;

    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Name cannot be empty')));
      return;
    }

    setState(() => _isLoading = true);
    try {
      await FirebaseFirestore.instance.collection('customers').doc(user.uid).update({
        'fullName': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated successfully')));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error saving profile: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showLogoutDialog() {
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
              context.go(AppRoutes.welcome);
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(onPressed: _showLogoutDialog, icon: const Icon(Icons.logout, color: Colors.red)),
        ],
      ),
      body: userAsync.when(
        data: (user) {
          if (user == null) return const Center(child: Text('Not logged in'));
          
          final isGoogleAuth = user.authProvider == 'google';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickAndUploadImage,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primary.withOpacity(0.2), width: 4),
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey.shade100,
                          backgroundImage: user.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
                          child: user.photoUrl == null ? const Icon(Icons.person, size: 60, color: Colors.grey) : null,
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.primary,
                          child: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  enabled: !isGoogleAuth,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    prefixIcon: const Icon(Icons.email_outlined),
                    filled: isGoogleAuth,
                    fillColor: isGoogleAuth ? Colors.grey.shade50 : null,
                    helperText: isGoogleAuth ? 'Email from Google account cannot be changed' : null,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  enabled: false,
                  controller: TextEditingController(text: user.phone),
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: const Icon(Icons.phone_outlined),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Save Changes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 40),
                const Divider(),
                const SizedBox(height: 8),
                _ProfileMenuItem(
                  icon: Icons.location_on_outlined,
                  title: 'Saved Addresses',
                  onTap: () => context.push(AppRoutes.savedAddresses),
                ),
                _ProfileMenuItem(
                  icon: Icons.history_outlined,
                  title: 'Booking History',
                  onTap: () => context.push(AppRoutes.myBookings),
                ),
                _ProfileMenuItem(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'My Wallet',
                  onTap: () => context.push(AppRoutes.wallet),
                ),
                _ProfileMenuItem(
                  icon: Icons.share_outlined,
                  title: 'Refer & Earn',
                  onTap: () => context.push(AppRoutes.referral),
                ),
                _ProfileMenuItem(
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  onTap: () => context.push(AppRoutes.support),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
    );
  }
}

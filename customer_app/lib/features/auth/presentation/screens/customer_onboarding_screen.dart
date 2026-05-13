import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/router/app_routes.dart';
import 'package:customer/core/theme/app_colors.dart';
import 'package:customer/features/auth/presentation/providers/auth_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class CustomerOnboardingScreen extends ConsumerStatefulWidget {
  const CustomerOnboardingScreen({super.key});

  @override
  ConsumerState<CustomerOnboardingScreen> createState() => _CustomerOnboardingScreenState();
}

class _CustomerOnboardingScreenState extends ConsumerState<CustomerOnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  String? _photoUrl;
  File? _imageFile;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.read(authNotifierProvider).value;
      if (user != null) {
        _nameController.text = user.fullName ?? '';
        _phoneController.text = user.phone?.replaceFirst('+91', '') ?? '';
        _emailController.text = user.email ?? '';
        _photoUrl = user.photoUrl;
      }
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final user = ref.read(authNotifierProvider).value!;

    try {
      String? finalPhotoUrl = _photoUrl;

      if (_imageFile != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('customers/${user.uid}/profile.jpg');
        await storageRef.putFile(_imageFile!);
        finalPhotoUrl = await storageRef.getDownloadURL();
      }

      await FirebaseFirestore.instance.collection('customers').doc(user.uid).update({
        'fullName': _nameController.text.trim(),
        'phone': '+91${_phoneController.text.trim()}',
        'email': _emailController.text.trim(),
        'photoUrl': finalPhotoUrl,
        'isProfileComplete': true,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Welcome to ServeNow, ${_nameController.text.split(' ').first}!')),
        );
        context.go(AppRoutes.home);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authNotifierProvider).value;
    final isPhoneAuth = user?.authProvider == 'phone';
    final isGoogleAuth = user?.authProvider == 'google';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete your profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authNotifierProvider.notifier).signOut(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Profile Photo
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : (_photoUrl != null ? NetworkImage(_photoUrl!) : null) as ImageProvider?,
                      child: _imageFile == null && _photoUrl == null
                          ? const Icon(Icons.person, size: 60, color: Colors.grey)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name*',
                  hintText: 'Enter your full name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter your name';
                  if (value.length < 3) return 'Name must be at least 3 characters';
                  if (RegExp(r'[0-9]').hasMatch(value)) return 'Name cannot contain numbers';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Phone
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number*',
                  prefixText: '+91 ',
                  prefixIcon: const Icon(Icons.phone_outlined),
                  filled: isPhoneAuth,
                  fillColor: isPhoneAuth ? Colors.grey.shade100 : null,
                ),
                keyboardType: TextInputType.phone,
                readOnly: isPhoneAuth,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter phone number';
                  if (value.length != 10) return 'Phone number must be 10 digits';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Email
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email (Optional)',
                  prefixIcon: const Icon(Icons.email_outlined),
                  filled: isGoogleAuth,
                  fillColor: isGoogleAuth ? Colors.grey.shade100 : null,
                ),
                keyboardType: TextInputType.emailAddress,
                readOnly: isGoogleAuth,
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Save & Continue',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

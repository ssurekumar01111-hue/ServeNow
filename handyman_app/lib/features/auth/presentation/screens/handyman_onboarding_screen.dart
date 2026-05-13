import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:handyman/core/router/app_routes.dart';
import 'package:handyman/core/theme/app_colors.dart';
import 'package:handyman/features/auth/presentation/providers/auth_provider.dart';

class HandymanOnboardingScreen extends ConsumerStatefulWidget {
  const HandymanOnboardingScreen({super.key});

  @override
  ConsumerState<HandymanOnboardingScreen> createState() => _HandymanOnboardingScreenState();
}

class _HandymanOnboardingScreenState extends ConsumerState<HandymanOnboardingScreen> {
  final _nameController = TextEditingController();
  final _serviceAreaController = TextEditingController();
  final _phoneController = TextEditingController();
  File? _image;
  File? _idProof;
  final List<String> _selectedSkills = [];
  final List<String> _availableSkills = [
    "AC Repair",
    "Electrical",
    "Plumbing",
    "Appliance Repair",
    "Carpentry",
    "Painting",
    "Cleaning",
    "Pest Control",
  ];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.read(authNotifierProvider).value;
      if (user != null && user.phone != null) {
        _phoneController.text = user.phone!;
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _serviceAreaController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  Future<void> _pickIdProof() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (pickedFile != null) {
      setState(() => _idProof = File(pickedFile.path));
    }
  }

  void _onSubmit() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter your name')));
      return;
    }
    if (_serviceAreaController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter your service area')));
      return;
    }
    if (_selectedSkills.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select at least one skill')));
      return;
    }
    if (_idProof == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please upload ID proof')));
      return;
    }

    setState(() => _isLoading = true);
    try {
      await ref.read(authNotifierProvider.notifier).completeRegistration(
            name: _nameController.text.trim(),
            skills: _selectedSkills,
            serviceArea: _serviceAreaController.text.trim(),
            photo: _image,
            idProof: _idProof!,
          );
      if (mounted) context.go(AppRoutes.pendingApproval);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Complete Your Profile'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                child: const Text(
                  'Welcome to ServeNow Pro!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              FadeInDown(
                delay: const Duration(milliseconds: 100),
                child: Text(
                  'Join our network of professionals and start earning.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: FadeInDown(
                  delay: const Duration(milliseconds: 150),
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey.shade100,
                          backgroundImage: _image != null ? FileImage(_image!) : null,
                          child: _image == null
                              ? Icon(Icons.person_outline, size: 60, color: Colors.grey.shade400)
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Full Name',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Enter your full name',
                        prefixIcon: const Icon(Icons.person_outline),
                        fillColor: Colors.grey.shade50,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              FadeInUp(
                delay: const Duration(milliseconds: 220),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Phone Number',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _phoneController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: 'Phone number',
                        prefixIcon: const Icon(Icons.phone_outlined),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              FadeInUp(
                delay: const Duration(milliseconds: 250),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Service Area',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _serviceAreaController,
                      decoration: InputDecoration(
                        hintText: 'e.g. City, Pincode',
                        prefixIcon: const Icon(Icons.location_on_outlined),                        fillColor: Colors.grey.shade50,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Your Skills',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _availableSkills.map((skill) {
                        final isSelected = _selectedSkills.contains(skill);
                        return FilterChip(
                          label: Text(skill),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedSkills.add(skill);
                              } else {
                                _selectedSkills.remove(skill);
                              }
                            });
                          },
                          selectedColor: AppColors.primary.withOpacity(0.2),
                          checkmarkColor: AppColors.primary,
                          labelStyle: TextStyle(
                            color: isSelected ? AppColors.primary : Colors.grey.shade700,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: isSelected ? AppColors.primary : Colors.grey.shade300,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              FadeInUp(
                delay: const Duration(milliseconds: 350),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ID Proof Document',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: _pickIdProof,
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
                        ),
                        child: _idProof != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(_idProof!, fit: BoxFit.cover),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_photo_alternate_outlined, size: 40, color: Colors.grey.shade400),
                                  const SizedBox(height: 8),
                                  Text('Upload ID Proof', style: TextStyle(color: Colors.grey.shade500)),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: AppColors.primaryGradient,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _onSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Submit Application',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
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

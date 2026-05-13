import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/core/router/app_routes.dart';
import 'package:provider/core/theme/app_colors.dart';
import 'package:provider/features/auth/presentation/providers/auth_provider.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  int _currentStep = 0;
  final _picker = ImagePicker();
  bool _isSubmitting = false;

  // Step 1: Business Info
  final _formKey1 = GlobalKey<FormState>();
  final _businessNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<String> _selectedCategories = [];
  List<Map<String, dynamic>> _categories = [];

  // Step 2: Documents Upload
  String? _businessLicenseUrl;
  String? _idProofUrl;
  String? _profilePhotoUrl;
  Map<String, double> _uploadProgress = {};

  // Step 3: Add First Service
  final _formKey3 = GlobalKey<FormState>();
  final _serviceNameController = TextEditingController();
  final _serviceDescriptionController = TextEditingController();
  final _servicePriceController = TextEditingController();
  final _serviceDurationController = TextEditingController();
  String? _serviceCategoryId;
  List<Map<String, dynamic>> _addedServices = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('categories').get();
      setState(() {
        _categories = snapshot.docs.map((doc) => {
          'id': doc.id,
          'name': doc.data()['name'],
          'icon': doc.data()['icon'],
        }).toList();
      });
    } catch (e) {
      debugPrint('Error fetching categories: $e');
    }
  }

  Future<void> _uploadFile(String type, String path) async {
    final user = ref.read(authNotifierProvider).value;
    if (user == null) return;

    final fileName = type == 'profile' ? 'photo.jpg' : (type == 'license' ? 'business_license.jpg' : 'id_proof.jpg');
    final folder = type == 'profile' ? 'profile' : 'documents';
    final storagePath = 'providers/${user.uid}/$folder/$fileName';
    
    final refStorage = FirebaseStorage.instance.ref().child(storagePath);
    final uploadTask = refStorage.putFile(File(path));

    uploadTask.snapshotEvents.listen((event) {
      setState(() {
        _uploadProgress[type] = event.bytesTransferred / event.totalBytes;
      });
    });

    try {
      await uploadTask;
      final url = await refStorage.getDownloadURL();
      setState(() {
        if (type == 'license') _businessLicenseUrl = url;
        if (type == 'id') _idProofUrl = url;
        if (type == 'profile') _profilePhotoUrl = url;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
    }
  }

  Future<void> _pickAndUpload(String type) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (pickedFile != null) {
      await _uploadFile(type, pickedFile.path);
    }
  }

  void _addService() {
    if (_formKey3.currentState!.validate()) {
      if (_serviceCategoryId == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a category for the service')));
        return;
      }
      setState(() {
        _addedServices.add({
          'name': _serviceNameController.text,
          'description': _serviceDescriptionController.text,
          'categoryId': _serviceCategoryId,
          'basePrice': double.parse(_servicePriceController.text),
          'duration': int.parse(_serviceDurationController.text),
        });
        _serviceNameController.clear();
        _serviceDescriptionController.clear();
        _servicePriceController.clear();
        _serviceDurationController.clear();
        _serviceCategoryId = null;
      });
    }
  }

  Future<void> _submitRegistration() async {
    setState(() => _isSubmitting = true);
    final user = ref.read(authNotifierProvider).value;
    if (user == null) return;

    try {
      final batch = FirebaseFirestore.instance.batch();

      // 1. Create Provider Document
      final providerRef = FirebaseFirestore.instance.collection('providers').doc(user.uid);
      batch.set(providerRef, {
        'uid': user.uid,
        'businessName': _businessNameController.text,
        'categories': _selectedCategories,
        'serviceArea': '${_cityController.text} - ${_pincodeController.text}',
        'phone': _phoneController.text,
        'description': _descriptionController.text,
        'businessLicenseUrl': _businessLicenseUrl,
        'idProofUrl': _idProofUrl,
        'photoUrl': _profilePhotoUrl,
        'onboardingStatus': 'pending_approval',
        'isActive': false,
        'rating': 0.0,
        'reviewCount': 0,
        'completedJobs': 0,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // 2. Create Service Documents
      for (var service in _addedServices) {
        final serviceRef = FirebaseFirestore.instance.collection('services').doc();
        batch.set(serviceRef, {
          ...service,
          'providerId': user.uid,
          'rating': 0.0,
          'reviewCount': 0,
          'isActive': true,
          'imageUrl': '',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      // 3. Admin Notification
      final notificationRef = FirebaseFirestore.instance.collection('admin_notifications').doc();
      batch.set(notificationRef, {
        'type': 'new_provider',
        'providerId': user.uid,
        'businessName': _businessNameController.text,
        'createdAt': FieldValue.serverTimestamp(),
      });

      await batch.commit();
      if (mounted) context.go(AppRoutes.verificationPending);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration failed: $e')));
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Provider Registration')),
      body: Column(
        children: [
          _buildProgressIndicator(),
          Expanded(
            child: _isSubmitting 
              ? const Center(child: CircularProgressIndicator())
              : _buildCurrentStep(),
          ),
        ],
      ),
      bottomNavigationBar: _isSubmitting ? null : _buildBottomButtons(),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: List.generate(4, (index) {
          final isActive = index <= _currentStep;
          return Expanded(
            child: Container(
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              color: isActive ? AppColors.primary : Colors.grey[300],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0: return _buildStep1();
      case 1: return _buildStep2();
      case 2: return _buildStep3();
      case 3: return _buildStep4();
      default: return const SizedBox();
    }
  }

  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Business Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            TextFormField(
              controller: _businessNameController,
              decoration: const InputDecoration(labelText: 'Business Name*', border: OutlineInputBorder()),
              validator: (v) => v!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            const Text('Categories*', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _categories.map((cat) {
                final categoryId = cat['id'] as String;
                final isSelected = _selectedCategories.contains(categoryId);
                return FilterChip(
                  label: Text(cat['name'] as String),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedCategories.add(categoryId);
                      } else {
                        _selectedCategories.remove(categoryId);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _cityController,
                    decoration: const InputDecoration(labelText: 'City*', border: OutlineInputBorder()),
                    validator: (v) => v!.isEmpty ? 'Required' : null,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _pincodeController,
                    decoration: const InputDecoration(labelText: 'Pincode*', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    validator: (v) => v!.isEmpty ? 'Required' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Business Phone*', border: OutlineInputBorder()),
              keyboardType: TextInputType.phone,
              validator: (v) => v!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Documents Upload', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildUploadItem('Business License / Shop Registration*', 'license', _businessLicenseUrl),
          const SizedBox(height: 24),
          _buildUploadItem('Owner ID Proof (Aadhar/PAN)*', 'id', _idProofUrl),
          const SizedBox(height: 24),
          _buildUploadItem('Profile Photo*', 'profile', _profilePhotoUrl),
        ],
      ),
    );
  }

  Widget _buildUploadItem(String label, String type, String? url) {
    final progress = _uploadProgress[type] ?? 0.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _pickAndUpload(type),
          child: Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[50],
            ),
            child: url != null 
              ? Stack(
                  children: [
                    ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(url, width: double.infinity, fit: BoxFit.cover)),
                    const Positioned(right: 8, top: 8, child: Icon(Icons.check_circle, color: Colors.green)),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (progress > 0 && progress < 1) ...[
                      CircularProgressIndicator(value: progress),
                      const SizedBox(height: 8),
                      Text('${(progress * 100).toInt()}%'),
                    ] else ...[
                      const Icon(Icons.cloud_upload_outlined, size: 32, color: Colors.grey),
                      const SizedBox(height: 8),
                      const Text('Tap to upload'),
                    ]
                  ],
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildStep3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Add Your Services', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          if (_addedServices.isNotEmpty) ...[
            const Text('Added Services:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ..._addedServices.map((s) => Card(
              child: ListTile(
                title: Text(s['name'] as String),
                subtitle: Text('₹${s['basePrice']} • ${s['duration']} mins'),
                trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => setState(() => _addedServices.remove(s))),
              ),
            )),
            const Divider(height: 32),
          ],
          Form(
            key: _formKey3,
            child: Column(
              children: [
                TextFormField(
                  controller: _serviceNameController,
                  decoration: const InputDecoration(labelText: 'Service Name*', border: OutlineInputBorder()),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _serviceCategoryId,
                  items: _categories.map((c) => DropdownMenuItem(value: c['id'] as String, child: Text(c['name'] as String))).toList(),
                  onChanged: (v) => setState(() => _serviceCategoryId = v),
                  decoration: const InputDecoration(labelText: 'Category*', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _serviceDescriptionController,
                  decoration: const InputDecoration(labelText: 'Service Description*', border: OutlineInputBorder()),
                  maxLines: 2,
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _servicePriceController,
                        decoration: const InputDecoration(labelText: 'Base Price (₹)*', border: OutlineInputBorder()),
                        keyboardType: TextInputType.number,
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _serviceDurationController,
                        decoration: const InputDecoration(labelText: 'Duration (mins)*', border: OutlineInputBorder()),
                        keyboardType: TextInputType.number,
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _addService,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Service'),
                  style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep4() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Review & Submit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildReviewItem('Business Name', _businessNameController.text),
          _buildReviewItem('Phone', _phoneController.text),
          _buildReviewItem('Area', '${_cityController.text} - ${_pincodeController.text}'),
          _buildReviewItem('Categories', _selectedCategories.length.toString()),
          _buildReviewItem('Documents', '3 Uploaded'),
          _buildReviewItem('Services', _addedServices.length.toString()),
          const SizedBox(height: 24),
          const AlertBanner(message: 'By submitting, you agree to our terms of service and verify that all provided information is accurate.'),
        ],
      ),
    );
  }

  Widget _buildReviewItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() => _currentStep--),
                style: OutlinedButton.styleFrom(minimumSize: const Size(0, 50)),
                child: const Text('Back'),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _onNextPressed,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(0, 50),
                backgroundColor: AppColors.primary,
              ),
              child: Text(_currentStep == 3 ? 'Submit Registration' : 'Next'),
            ),
          ),
        ],
      ),
    );
  }

  void _onNextPressed() {
    if (_currentStep == 0) {
      if (_formKey1.currentState!.validate()) {
        if (_selectedCategories.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Select at least one category')));
          return;
        }
        setState(() => _currentStep++);
      }
    } else if (_currentStep == 1) {
      if (_businessLicenseUrl == null || _idProofUrl == null || _profilePhotoUrl == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please upload all required documents')));
        return;
      }
      setState(() => _currentStep++);
    } else if (_currentStep == 2) {
      if (_addedServices.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please add at least one service')));
        return;
      }
      setState(() => _currentStep++);
    } else if (_currentStep == 3) {
      _submitRegistration();
    }
  }
}

class AlertBanner extends StatelessWidget {
  final String message;
  const AlertBanner({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(child: Text(message, style: const TextStyle(fontSize: 12, color: Colors.blue))),
        ],
      ),
    );
  }
}

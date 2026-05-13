import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/theme/app_colors.dart';
import 'package:customer/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class AddAddressScreen extends ConsumerStatefulWidget {
  const AddAddressScreen({super.key});

  @override
  ConsumerState<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends ConsumerState<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _areaController = TextEditingController();
  final _cityController = TextEditingController();
  final _pincodeController = TextEditingController();
  String _selectedLabel = 'Home';
  bool _isDefault = false;
  bool _isLoading = false;
  double? _lat;
  double? _lng;

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition();
        _lat = position.latitude;
        _lng = position.longitude;

        List<Placemark> placemarks = await placemarkFromCoordinates(_lat!, _lng!);
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          setState(() {
            _addressController.text = '${place.name}, ${place.street}';
            _areaController.text = place.subLocality ?? place.locality ?? '';
            _cityController.text = place.locality ?? '';
            _pincodeController.text = place.postalCode ?? '';
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not get location: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _saveAddress() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final user = ref.read(authNotifierProvider).value;
      if (user == null) return;

      final addressData = {
        'label': _selectedLabel,
        'fullAddress': _addressController.text.trim(),
        'area': _areaController.text.trim(),
        'city': _cityController.text.trim(),
        'pincode': _pincodeController.text.trim(),
        'lat': _lat ?? 0.0,
        'lng': _lng ?? 0.0,
        'isDefault': _isDefault,
        'createdAt': FieldValue.serverTimestamp(),
      };

      final addressesRef = FirebaseFirestore.instance
          .collection('customers')
          .doc(user.uid)
          .collection('addresses');

      // If set as default, unset others
      if (_isDefault) {
        final existingDefaults = await addressesRef.where('isDefault', isEqualTo: true).get();
        for (var doc in existingDefaults.docs) {
          await doc.reference.update({'isDefault': false});
        }
      }

      // Check if it's the first address
      final existingCount = await addressesRef.count().get();
      if (existingCount.count == 0) {
        addressData['isDefault'] = true;
      }

      final newAddressDoc = await addressesRef.add(addressData);

      if (addressData['isDefault'] == true) {
        await FirebaseFirestore.instance.collection('customers').doc(user.uid).update({
          'defaultAddressId': newAddressDoc.id,
        });
      }

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Address')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Label chips
              const Text('Address Label', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Row(
                children: ['Home', 'Work', 'Other'].map((label) {
                  final isSelected = _selectedLabel == label;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: ChoiceChip(
                      label: Text(label),
                      selected: isSelected,
                      onSelected: (val) => setState(() => _selectedLabel = label),
                      selectedColor: AppColors.primary.withOpacity(0.2),
                      labelStyle: TextStyle(
                        color: isSelected ? AppColors.primary : Colors.black87,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              // Use current location button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _isLoading ? null : _getCurrentLocation,
                  icon: const Icon(Icons.my_location),
                  label: const Text('Use my current location'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Full Address (House/Flat No, Building)*'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _areaController,
                decoration: const InputDecoration(labelText: 'Area / Locality*'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _cityController,
                      decoration: const InputDecoration(labelText: 'City*'),
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _pincodeController,
                      decoration: const InputDecoration(labelText: 'Pincode*'),
                      keyboardType: TextInputType.number,
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Set as default address'),
                value: _isDefault,
                onChanged: (val) => setState(() => _isDefault = val),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveAddress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Save Address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

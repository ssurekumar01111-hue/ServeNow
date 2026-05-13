import 'package:customer/core/router/app_routes.dart';
import 'package:customer/features/auth/domain/entities/user_entity.dart';
import 'package:customer/features/auth/presentation/providers/auth_provider.dart';
import 'package:customer/features/booking/presentation/providers/booking_providers.dart' as booking_providers; // Alias changed
import 'package:customer/features/services/domain/entities/service_entity.dart';
import 'package:customer/features/services/presentation/providers/services_providers.dart';
import 'package:customer/features/home/presentation/providers/location_provider.dart'; // Keep original import for location_provider
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:customer/core/theme/app_colors.dart'; // Import AppColors

class BookingFormScreen extends ConsumerStatefulWidget {
  final ServiceEntity? service;
  
  const BookingFormScreen({
    this.service,
    super.key,
  });

  @override
  ConsumerState<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends ConsumerState<BookingFormScreen> {
  int _currentStep = 0;
  final _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Access BookingFormState from the provider
    final booking_providers.BookingFormState bookingFormState = ref.watch(booking_providers.createBookingProvider);
    final service = widget.service;

    if (service == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('No service selected for booking.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Book ${service.name}')),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: Theme.of(context).primaryColor,
          ),
        ),
        child: Column(
          children: [
            // Custom Step Indicator
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              color: Colors.grey.shade50,
              child: Row(
                children: List.generate(4, (index) {
                  final isCompleted = index < _currentStep;
                  final isActive = index == _currentStep;
                  return Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isCompleted || isActive ? AppColors.primary : Colors.grey.shade300,
                          ),
                          child: Center(
                            child: isCompleted 
                              ? const Icon(Icons.check, size: 16, color: Colors.white)
                              : Text('${index + 1}', style: TextStyle(color: isActive ? AppColors.primary : Colors.black54, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ['Address', 'Provider', 'Date', 'Notes'][index],
                          style: TextStyle(
                            fontSize: 10,
                            color: isActive ? AppColors.primary : Colors.black54,
                            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: _buildStepContent(service, bookingFormState),
              ),
            ),
            
            // Fixed Navigation Buttons at bottom
            Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, MediaQuery.of(context).padding.bottom + 16),
              child: Row(
                children: [
                  if (_currentStep > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => setState(() => _currentStep--),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Back'),
                      ),
                    ),
                  if (_currentStep > 0) const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () => _onContinue(service, bookingFormState),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(_currentStep == 3 ? 'Review & Checkout' : 'Continue'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onContinue(ServiceEntity service, booking_providers.BookingFormState bookingFormState) {
    if (_currentStep == 0 && bookingFormState.address == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select or enter an address')));
      return;
    }
    if (_currentStep == 1 && bookingFormState.providerId == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a provider')));
      return;
    }
    if (_currentStep == 2 && (bookingFormState.selectedDate == null || bookingFormState.selectedTime == null)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select date and time')));
      return;
    }

    if (_currentStep < 3) {
      setState(() => _currentStep++);
    } else {
      ref.read(booking_providers.createBookingProvider.notifier).updateNotes(_notesController.text);
      context.push(AppRoutes.checkout, extra: {
        'booking': bookingFormState,
        'service': service,
      });
    }
  }

  Widget _buildStepContent(ServiceEntity service, booking_providers.BookingFormState bookingFormState) {
    switch (_currentStep) {
      case 0:
        return _AddressStep(
          onAddressSelected: (address) {
            ref.read(booking_providers.createBookingProvider.notifier).updateAddress(address);
          },
        );
      case 1:
        return _ProviderStep(
          categoryId: service.categoryId,
          selectedProviderId: bookingFormState.providerId,
          onProviderSelected: (id, name) {
            ref.read(booking_providers.createBookingProvider.notifier).updateProvider(id, name);
          },
        );
      case 2:
        return Column(
          children: [
            const Text('Select Service Date', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            CalendarDatePicker(
              initialDate: bookingFormState.selectedDate ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 30)),
              onDateChanged: (date) {
                ref.read(booking_providers.createBookingProvider.notifier).updateDateTime(date, bookingFormState.selectedTime ?? DateTime(date.year, date.month, date.day, 10));
              },
            ),
            const SizedBox(height: 24),
            const Text('Select Time Slot', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(5, (index) {
                final hour = 9 + index;
                final isSelected = bookingFormState.selectedTime?.hour == hour;
                return ChoiceChip(
                  label: Text('$hour:00 ${hour >= 12 ? 'PM' : 'AM'}'),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (bookingFormState.selectedDate != null) {
                      final time = DateTime(bookingFormState.selectedDate!.year, bookingFormState.selectedDate!.month, bookingFormState.selectedDate!.day, hour);
                      ref.read(booking_providers.createBookingProvider.notifier).updateDateTime(bookingFormState.selectedDate!, time);
                    }
                  },
                );
              }),
            ),
          ],
        );
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Additional Notes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(
                hintText: 'Add special instructions for the professional...',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              maxLines: 5,
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class _ProviderStep extends ConsumerWidget {
  final String categoryId;
  final String? selectedProviderId;
  final Function(String, String) onProviderSelected;

  const _ProviderStep({
    required this.categoryId,
    this.selectedProviderId,
    required this.onProviderSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providersAsync = ref.watch(providersByCategoryProvider(categoryId)); // Use alias

    return providersAsync.when(
      data: (providersList) { // Renamed providers to providersList to avoid conflict
        if (providersList.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "No providers available for this service in your area. Please try again later.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Choose a professional:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: providersList.length,
              itemBuilder: (context, index) {
                final provider = providersList[index];
                final isSelected = selectedProviderId == provider.id;

                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                      child: Text(provider.businessName[0].toUpperCase()),
                    ),
                    title: Text(provider.businessName, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(provider.rating.toString()),
                        const SizedBox(width: 8),
                        Text('(${provider.reviewCount} reviews)'),
                      ],
                    ),
                    trailing: isSelected 
                      ? Icon(Icons.check_circle, color: Theme.of(context).primaryColor)
                      : null,
                    onTap: () => onProviderSelected(provider.id, provider.businessName),
                  ),
                );
              },
            ),
          ],
        );
      },
      loading: () => const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator())),
      error: (e, st) => Center(child: Text('Error loading providers: $e')),
    );
  }
}

// Address Step Widget
class _AddressStep extends ConsumerStatefulWidget {
  final Function(AddressEntity) onAddressSelected;
  const _AddressStep({required this.onAddressSelected});

  @override
  ConsumerState<_AddressStep> createState() => _AddressStepState();
}

class _AddressStepState extends ConsumerState<_AddressStep> {
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _pincodeController = TextEditingController();
  bool _isLoadingLocation = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill with current location if none exists in state
    WidgetsBinding.instance.addPostFrameCallback((_) {
       final currentAddress = ref.read(booking_providers.createBookingProvider).address; // Use alias
       if (currentAddress != null) {
         _streetController.text = currentAddress.fullAddress ?? '';
         _cityController.text = currentAddress.city ?? '';
         _pincodeController.text = currentAddress.pincode ?? '';
       } else {
         // Try to use the location already in locationProvider
         final locationAsync = ref.read(locationProvider);
         if (locationAsync.hasValue) {
           final location = locationAsync.value!;
           _streetController.text = location.address;
           _cityController.text = location.cityName;
           _notifyAddress(location.lat, location.lng);
         } else {
           _loadCurrentLocation();
         }
       }
    });
  }

  Future<void> _loadCurrentLocation() async {
    setState(() => _isLoadingLocation = true);
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      
      if (permission == LocationPermission.deniedForever) {
        setState(() => _isLoadingLocation = false);
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );
      final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      final place = placemarks.first;
      setState(() {
        _streetController.text = '${place.subLocality ?? ''}, ${place.thoroughfare ?? ''}'.trim().replaceAll(RegExp(r'^,\s*'), '');
        _cityController.text = place.locality ?? place.administrativeArea ?? '';
        _pincodeController.text = place.postalCode ?? '';
        _isLoadingLocation = false;
      });
      _notifyAddress(position.latitude, position.longitude);
    } catch (e) {
      debugPrint('Error getting location: $e');
      setState(() => _isLoadingLocation = false);
    }
  }

  void _notifyAddress(double lat, double lng) {
    if (_streetController.text.isNotEmpty) {
      widget.onAddressSelected(AddressEntity(
        fullAddress: _streetController.text,
        city: _cityController.text,
        state: '',
        lat: lat,
        lng: lng,
        pincode: _pincodeController.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Service Location', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          // Use current location button
          OutlinedButton.icon(
            onPressed: _isLoadingLocation ? null : _loadCurrentLocation,
            icon: _isLoadingLocation
              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
              : const Icon(Icons.my_location_rounded),
            label: Text(_isLoadingLocation ? 'Detecting location...' : 'Use Current Location'),
          ),
          const SizedBox(height: 16),
          // Street address
          TextField(
            controller: _streetController,
            decoration: const InputDecoration(
              labelText: 'Street / Area',
              hintText: 'e.g. 123 Main Street, MG Road',
              prefixIcon: Icon(Icons.location_on_outlined),
              border: OutlineInputBorder(),
            ),
            onChanged: (_) => _notifyAddress(0, 0),
          ),
          const SizedBox(height: 12),
          // City
          TextField(
            controller: _cityController,
            decoration: const InputDecoration(
              labelText: 'City',
              prefixIcon: Icon(Icons.location_city_outlined),
              border: OutlineInputBorder(),
            ),
            onChanged: (_) => _notifyAddress(0, 0),
          ),
          const SizedBox(height: 12),
          // Pincode
          TextField(
            controller: _pincodeController,
            keyboardType: TextInputType.number,
            maxLength: 6,
            decoration: const InputDecoration(
              labelText: 'Pincode',
              prefixIcon: Icon(Icons.pin_drop_outlined),
              counterText: '',
              border: OutlineInputBorder(),
            ),
            onChanged: (_) => _notifyAddress(0, 0),
          ),
          const SizedBox(height: 24),
          // Saved addresses from user profile
          const Text('Or choose a saved address:', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Consumer(
            builder: (context, ref, _) {
              final addressesAsync = ref.watch(booking_providers.savedAddressesProvider); // Use alias
              return addressesAsync.when(
                data: (addresses) {
                  if (addresses.isEmpty) {
                    return const Text('No saved addresses found');
                  }
                  return Column(
                    children: addresses.map((addr) => Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: const Icon(Icons.home_outlined),
                        title: Text(addr.fullAddress ?? '', maxLines: 1, overflow: TextOverflow.ellipsis),
                        subtitle: Text('${addr.city ?? ''} - ${addr.pincode ?? ''}'),
                        onTap: () {
                          _streetController.text = addr.fullAddress ?? '';
                          _cityController.text = addr.city ?? '';
                          _pincodeController.text = addr.pincode ?? '';
                          widget.onAddressSelected(addr);
                        },
                      ),
                    )).toList(),
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (_, __) => const Text('Error loading addresses'),
              );
            },
          ),
        ],
      ),
    );
  }
}

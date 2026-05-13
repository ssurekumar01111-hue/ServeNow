import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationData {
  final double lat;
  final double lng;
  final String cityName;
  final String address;
  LocationData({required this.lat, required this.lng, required this.cityName, required this.address});
}

class LocationNotifier extends AsyncNotifier<LocationData> {
  @override
  Future<LocationData> build() async {
    return await _fetchLocation();
  }

  Future<LocationData> _fetchLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions permanently denied.');
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      timeLimit: const Duration(seconds: 10),
    );

    final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    final place = placemarks.first;
    final cityName = place.locality ?? place.administrativeArea ?? 'Your Location';
    final address = '${place.subLocality ?? ''}, $cityName'.trim();
    
    return LocationData(
      lat: position.latitude,
      lng: position.longitude,
      cityName: cityName,
      address: address,
    );
  }

  Future<void> refreshLocation() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchLocation());
  }
}

final locationProvider = AsyncNotifierProvider<LocationNotifier, LocationData>(LocationNotifier.new);

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  static StreamSubscription<Position>? _positionSubscription;

  static Future<bool> requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      // Check for always permission (needed for background tracking)
      if (await Permission.locationAlways.isDenied) {
        await Permission.locationAlways.request();
      }
      return true;
    }
    return false;
  }

  static Future<void> startLiveTracking(String handymanId) async {
    await stopLiveTracking();

    late final LocationSettings locationSettings;

    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 0,
        intervalDuration: const Duration(seconds: 10),
      );
    } else {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      );
    }

    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen(
      (Position position) {
        FirebaseFirestore.instance
            .collection('handymen')
            .doc(handymanId)
            .set({
          'location': {
            'lat': position.latitude,
            'lng': position.longitude,
            'updatedAt': FieldValue.serverTimestamp(),
          },
        }, SetOptions(merge: true));
      },
    );
  }

  static Future<void> stopLiveTracking() async {
    await _positionSubscription?.cancel();
    _positionSubscription = null;
  }
}

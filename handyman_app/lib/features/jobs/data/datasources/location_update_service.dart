import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class LocationUpdateService {
  LocationUpdateService(this.firestore);
  final FirebaseFirestore firestore;
  StreamSubscription<Position>? _positionSubscription;

  Future<void> startTracking(String handymanId, String bookingId) async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }

    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    _positionSubscription = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (position) {
        firestore.collection('handymen').doc(handymanId).set({
          'location': {
            'lat': position.latitude,
            'lng': position.longitude,
            'updatedAt': FieldValue.serverTimestamp(),
            'bookingId': bookingId,
          }
        }, SetOptions(merge: true));
      },
    );
  }

  void stopTracking() {
    _positionSubscription?.cancel();
    _positionSubscription = null;
  }
}

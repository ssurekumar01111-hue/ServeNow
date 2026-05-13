import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/providers/firebase_providers.dart';
import 'package:customer/features/tracking/domain/entities/handyman_location_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final handymanLocationProvider = StreamProvider.family<HandymanLocationEntity, String>((ref, handymanId) {
  return ref.watch(firestoreProvider)
      .collection('handymen')
      .doc(handymanId)
      .snapshots()
      .map((doc) {
        final data = doc.data()?['location'] as Map<String, dynamic>?;
        if (data == null) throw Exception('Location not found');
        return HandymanLocationEntity(
          latitude: data['lat'] as double,
          longitude: data['lng'] as double,
          updatedAt: (data['updatedAt'] as Timestamp).toDate(),
          bookingId: data['bookingId'] as String,
        );
      });
});

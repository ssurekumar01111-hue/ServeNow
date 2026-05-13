import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/features/home/data/models/banner_model.dart';
import 'package:customer/features/home/data/models/category_model.dart';
import 'package:customer/features/home/data/models/provider_summary_model.dart';
import 'package:geolocator/geolocator.dart';

abstract class HomeRemoteDataSource {
  Stream<List<CategoryModel>> getCategories();
  Stream<List<BannerModel>> getBanners();
  Stream<List<ProviderSummaryModel>> getNearbyProviders(double lat, double lng);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseFirestore _firestore;

  HomeRemoteDataSourceImpl(this._firestore);

  @override
  Stream<List<CategoryModel>> getCategories() {
    return _firestore
        .collection('categories')
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CategoryModel.fromFirestore(doc))
            .toList());
  }

  @override
  Stream<List<BannerModel>> getBanners() {
    return _firestore
        .collection('banners')
        .where('isActive', isEqualTo: true)
        .orderBy('sortOrder')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => BannerModel.fromFirestore(doc))
            .toList());
  }

  @override
  Stream<List<ProviderSummaryModel>> getNearbyProviders(double lat, double lng) {
    return _firestore
        .collection('providers')
        .where('onboardingStatus', isEqualTo: 'approved')
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      final providers = snapshot.docs.map((doc) {
        final data = doc.data();
        double providerLat = 0.0;
        double providerLng = 0.0;

        // Try different location structures
        if (data.containsKey('location') && data['location'] is Map) {
          final loc = data['location'] as Map;
          if (loc['geopoint'] is GeoPoint) {
            final gp = loc['geopoint'] as GeoPoint;
            providerLat = gp.latitude;
            providerLng = gp.longitude;
          } else {
            providerLat = (loc['lat'] ?? loc['latitude'] ?? 0.0).toDouble();
            providerLng = (loc['lng'] ?? loc['longitude'] ?? 0.0).toDouble();
          }
        } else {
          providerLat = (data['lat'] ?? data['latitude'] ?? 0.0).toDouble();
          providerLng = (data['lng'] ?? data['longitude'] ?? 0.0).toDouble();
        }

        double distance = 0.0;
        if (providerLat != 0.0 && providerLng != 0.0) {
          distance = Geolocator.distanceBetween(lat, lng, providerLat, providerLng) / 1000;
        }

        return ProviderSummaryModel.fromFirestore(doc, distance);
      }).toList();

      // Sort by distance
      providers.sort((a, b) => (a.distance ?? 0.0).compareTo(b.distance ?? 0.0));
      
      // Limit to 10
      return providers.take(10).toList();
    });
  }
}

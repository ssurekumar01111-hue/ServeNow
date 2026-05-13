import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/features/services/data/models/provider_detail_model.dart';
import 'package:customer/features/services/data/models/service_model.dart';

abstract class ServicesRemoteDataSource {
  Stream<List<ServiceModel>> getServicesByCategory(String categoryId);
  Stream<List<ServiceModel>> getAllServices();
  Stream<List<ServiceModel>> getPopularServices();
  Stream<ProviderDetailModel> getProviderDetail(String providerId);
  Stream<ServiceModel?> getServiceById(String serviceId);
  Stream<List<ProviderDetailModel>> getProvidersByCategory(String categoryId);
  Stream<List<ServiceModel>> searchServices(String query);
}

class ServicesRemoteDataSourceImpl implements ServicesRemoteDataSource {
  ServicesRemoteDataSourceImpl(this._firestore);
  final FirebaseFirestore _firestore;

  @override
  Stream<ServiceModel?> getServiceById(String serviceId) {
    return _firestore
        .collection('services')
        .doc(serviceId)
        .snapshots()
        .map((doc) => doc.exists ? ServiceModel.fromFirestore(doc) : null);
  }

  @override
  Stream<List<ServiceModel>> getServicesByCategory(String categoryId) {
    return _firestore
        .collection('services')
        .where('categoryId', isEqualTo: categoryId)
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ServiceModel.fromFirestore(doc))
            .toList());
  }

  @override
  Stream<List<ServiceModel>> getAllServices() {
    return _firestore
        .collection('services')
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ServiceModel.fromFirestore(doc))
            .toList());
  }

  @override
  Stream<List<ServiceModel>> getPopularServices() {
    return _firestore
        .collection('services')
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      final services = snapshot.docs
          .map((doc) => ServiceModel.fromFirestore(doc))
          .toList();
      // Sort by bookingCount descending in Dart
      services.sort((a, b) => b.bookingCount.compareTo(a.bookingCount));
      return services.take(10).toList();
    });
  }

  @override
  Stream<ProviderDetailModel> getProviderDetail(String providerId) {
    return _firestore.collection('providers').doc(providerId).snapshots().asyncMap((doc) async {
      final data = doc.data() as Map<String, dynamic>? ?? {};
      final List<String> categories = List<String>.from(data['categories'] as Iterable? ?? []);
      
      QuerySnapshot servicesSnapshot;
      if (categories.isNotEmpty) {
        servicesSnapshot = await _firestore
            .collection('services')
            .where('categoryId', whereIn: categories)
            .where('isActive', isEqualTo: true)
            .get();
      } else {
        servicesSnapshot = await _firestore
            .collection('services')
            .where('providerId', isEqualTo: providerId)
            .where('isActive', isEqualTo: true)
            .get();
      }
          
      final services = servicesSnapshot.docs
          .map((s) => ServiceModel.fromFirestore(s))
          .toList();
          
      return ProviderDetailModel.fromFirestore(doc, services);
    });
  }

  @override
  Stream<List<ProviderDetailModel>> getProvidersByCategory(String categoryId) {
    return _firestore
        .collection('providers')
        .where('onboardingStatus', isEqualTo: 'approved')
        .where('isActive', isEqualTo: true)
        .where('categories', arrayContains: categoryId)
        .snapshots()
        .asyncMap((snapshot) async {
      final List<ProviderDetailModel> providers = [];
      for (final doc in snapshot.docs) {
        final servicesSnapshot = await _firestore
            .collection('services')
            .where('providerId', isEqualTo: doc.id)
            .where('isActive', isEqualTo: true)
            .get();
        final services = servicesSnapshot.docs
            .map((s) => ServiceModel.fromFirestore(s))
            .toList();
        providers.add(ProviderDetailModel.fromFirestore(doc, services));
      }
      return providers;
    });
  }

  @override
  Stream<List<ServiceModel>> searchServices(String query) {
    if (query.isEmpty) return Stream.value([]);
    
    return _firestore
        .collection('services')
        .where('isActive', isEqualTo: true)
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: query + '\uf8ff')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ServiceModel.fromFirestore(doc))
            .toList());
  }
}

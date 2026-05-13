import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/features/services/domain/entities/service_entity.dart';

abstract class ServicesRemoteDataSource {
  Future<List<ServiceEntity>> getMyServices(String providerId);
  Future<void> addService(ServiceEntity service, String providerId);
  Future<void> updateService(ServiceEntity service);
  Future<void> deleteService(String serviceId);
  Future<void> toggleServiceStatus(String serviceId, bool isActive);
}

class ServicesRemoteDataSourceImpl implements ServicesRemoteDataSource {
  ServicesRemoteDataSourceImpl(this.firestore);
  final FirebaseFirestore firestore;

  @override
  Future<List<ServiceEntity>> getMyServices(String providerId) async {
    final snapshot = await firestore
        .collection('services')
        .where('providerId', isEqualTo: providerId)
        .get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return ServiceEntity(
        id: doc.id,
        name: data['name'] as String,
        categoryId: data['categoryId'] as String,
        description: data['description'] as String,
        basePrice: (data['basePrice'] as num).toDouble(),
        isActive: data['isActive'] as bool,
        workingHours: (data['workingHours'] as Map<String, dynamic>?) ?? {},
        estimatedDuration: (data['estimatedDuration'] as int?) ?? 60,
        images: List<String>.from(data['images'] as Iterable<dynamic>? ?? []),
        packages: (data['packages'] as List?)?.map((p) {
          final map = p as Map<String, dynamic>;
          return ServicePackage(
            name: map['name'] as String,
            description: map['description'] as String,
            price: (map['price'] as num).toDouble(),
            duration: map['duration'] as int,
          );
        }).toList() ?? [],
      );
    }).toList();
  }

  @override
  Future<void> addService(ServiceEntity service, String providerId) async {
    await firestore.collection('services').add({
      ..._serviceToMap(service),
      'providerId': providerId,
    });
  }

  @override
  Future<void> updateService(ServiceEntity service) async {
    await firestore.collection('services').doc(service.id).update(_serviceToMap(service));
  }

  @override
  Future<void> deleteService(String serviceId) async {
    await firestore.collection('services').doc(serviceId).delete();
  }

  @override
  Future<void> toggleServiceStatus(String serviceId, bool isActive) async {
    await firestore.collection('services').doc(serviceId).update({'isActive': isActive});
  }

  Map<String, dynamic> _serviceToMap(ServiceEntity s) {
    return {
      'name': s.name,
      'categoryId': s.categoryId,
      'description': s.description,
      'basePrice': s.basePrice,
      'isActive': s.isActive,
      'workingHours': s.workingHours,
      'estimatedDuration': s.estimatedDuration,
      'images': s.images,
      'packages': s.packages.map((p) => {
        'name': p.name,
        'description': p.description,
        'price': p.price,
        'duration': p.duration,
      }).toList(),
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/features/handymen/domain/entities/handyman_entity.dart';

abstract class HandymenRemoteDataSource {
  Future<List<HandymanEntity>> getMyHandymen(String providerId);
  Future<void> addHandyman(HandymanEntity handyman);
  Future<void> updateHandymanStatus(String handymanId, bool isOnline);
}

class HandymenRemoteDataSourceImpl implements HandymenRemoteDataSource {
  HandymenRemoteDataSourceImpl(this.firestore);
  final FirebaseFirestore firestore;

  @override
  Future<List<HandymanEntity>> getMyHandymen(String providerId) async {
    final snapshot = await firestore
        .collection('handymen')
        .where('providerId', isEqualTo: providerId)
        .get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return HandymanEntity(
        id: doc.id,
        providerId: data['providerId'] as String,
        name: data['name'] as String,
        phone: data['phone'] as String,
        skills: List<String>.from(data['skills'] as Iterable<dynamic>? ?? []),
        photoUrl: (data['photoUrl'] as String?) ?? '',
        idProofUrl: (data['idProofUrl'] as String?) ?? '',
        commissionRate: (data['commissionRate'] as int?) ?? 0,
        isOnline: (data['isOnline'] as bool?) ?? false,
        isAvailable: (data['isAvailable'] as bool?) ?? true,
      );
    }).toList();
  }

  @override
  Future<void> addHandyman(HandymanEntity h) async {
    await firestore.collection('handymen').add({
      'providerId': h.providerId,
      'name': h.name,
      'phone': h.phone,
      'skills': h.skills,
      'photoUrl': h.photoUrl,
      'idProofUrl': h.idProofUrl,
      'commissionRate': h.commissionRate,
      'isOnline': false,
      'isAvailable': true,
      'role': 'handyman',
    });
  }

  @override
  Future<void> updateHandymanStatus(String handymanId, bool isOnline) async {
    await firestore.collection('handymen').doc(handymanId).update({'isOnline': isOnline});
  }
}

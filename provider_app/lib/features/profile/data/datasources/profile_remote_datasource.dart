import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/features/profile/domain/entities/provider_profile_entity.dart';

abstract class ProfileRemoteDataSource {
  Future<ProviderProfileEntity?> getProfile(String providerId);
  Future<void> updateProfile(ProviderProfileEntity profile);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl(this.firestore);
  final FirebaseFirestore firestore;

  @override
  Future<ProviderProfileEntity?> getProfile(String providerId) async {
    final doc = await firestore.collection('providers').doc(providerId).get();
    if (!doc.exists) return null;
    return ProviderProfileEntity.fromFirestore(doc);
  }

  @override
  Future<void> updateProfile(ProviderProfileEntity p) async {
    await firestore.collection('providers').doc(p.id).set(p.toFirestore(), SetOptions(merge: true));
  }
}

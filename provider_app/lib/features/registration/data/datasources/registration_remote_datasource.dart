import 'package:cloud_firestore/cloud_firestore.dart';

abstract class RegistrationRemoteDataSource {
  Future<void> registerProvider(String providerId, Map<String, dynamic> data);
}

class RegistrationRemoteDataSourceImpl implements RegistrationRemoteDataSource {
  RegistrationRemoteDataSourceImpl(this.firestore);
  final FirebaseFirestore firestore;

  @override
  Future<void> registerProvider(String providerId, Map<String, dynamic> data) async {
    await firestore.collection('providers').doc(providerId).set({
      ...data,
      'isApproved': false,
      'isVerified': false,
      'role': 'provider',
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}

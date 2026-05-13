import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:handyman/features/profile/data/models/handyman_model.dart';
import 'package:handyman/features/profile/domain/entities/handyman_profile_entity.dart';

abstract class ProfileRemoteDataSource {
  Stream<HandymanProfileEntity?> getProfile(String handymanId);
  Future<void> updateOnlineStatus(String handymanId, bool isOnline);
  Future<void> updateProfilePhoto(String handymanId, File photo);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl(this.firestore, this.storage);
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  @override
  Stream<HandymanProfileEntity?> getProfile(String handymanId) {
    return firestore.collection('handymen').doc(handymanId).snapshots().map((doc) {
      if (!doc.exists) return null;
      final data = doc.data()!;
      data['uid'] = doc.id;
      return HandymanModel.fromJson(data).toEntity();
    });
  }

  @override
  Future<void> updateOnlineStatus(String handymanId, bool isOnline) async {
    await firestore.collection('handymen').doc(handymanId).set(
      {'isOnline': isOnline},
      SetOptions(merge: true),
    );
  }

  @override
  Future<void> updateProfilePhoto(String handymanId, File photo) async {
    final ref = storage.ref().child('handymen/$handymanId/profile.jpg');
    await ref.putFile(photo);
    final url = await ref.getDownloadURL();
    await firestore.collection('handymen').doc(handymanId).set(
      {'photoUrl': url},
      SetOptions(merge: true),
    );
  }
}

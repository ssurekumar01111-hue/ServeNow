import 'package:handyman/core/constants/booking_status.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:handyman/features/jobs/data/models/booking_model.dart';
import 'package:handyman/features/jobs/domain/entities/job_entity.dart';

abstract class JobsRemoteDataSource {
  Stream<List<BookingModel>> getJobs(String handymanId);
  Stream<List<BookingModel>> getJobsByStatus(String handymanId, String status);
  Stream<List<BookingModel>> getActiveJobs(String handymanId);
  Future<void> updateJobStatus(String jobId, JobStatus status, {Map<String, dynamic>? extraData});
  Future<String> uploadJobPhoto(String jobId, String type, File photo);
  Future<void> collectCash(String jobId, double amount, String handymanId);
}

class JobsRemoteDataSourceImpl implements JobsRemoteDataSource {
  JobsRemoteDataSourceImpl(this.firestore, this.storage);
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  @override
  Stream<List<BookingModel>> getJobs(String handymanId) {
    print('🔍 Fetching jobs for handymanId: $handymanId');
    return firestore
        .collection('bookings')
        .where('assignedHandymanId', isEqualTo: handymanId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          print('✅ Jobs found: ${snapshot.docs.length}');
          return snapshot.docs.map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            try {
              return BookingModel.fromJson(data);
            } catch (e) {
              print('BookingModel parse error: $e');
              print('Data: $data');
              rethrow;
            }
          }).toList();
        });
  }

  @override
  Stream<List<BookingModel>> getJobsByStatus(String handymanId, String status) {
    return firestore
        .collection('bookings')
        .where('assignedHandymanId', isEqualTo: handymanId)
        .where('status', isEqualTo: status)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              data['id'] = doc.id;
              return BookingModel.fromJson(data);
            }).toList());
  }

  @override
  Stream<List<BookingModel>> getActiveJobs(String handymanId) {
    return firestore
        .collection('bookings')
        .where('assignedHandymanId', isEqualTo: handymanId)
        .where('status', whereIn: [BookingStatuses.enRoute, BookingStatuses.arrived, BookingStatuses.inProgress])
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              data['id'] = doc.id;
              return BookingModel.fromJson(data);
            }).toList());
  }

  @override
  Future<void> updateJobStatus(String jobId, JobStatus status, {Map<String, dynamic>? extraData}) async {
    final updateData = {
      'status': status.dbValue,
      'updatedAt': FieldValue.serverTimestamp(),
      if (extraData != null) ...extraData,
    };
    await firestore.collection('bookings').doc(jobId).update(updateData);
  }

  @override
  Future<String> uploadJobPhoto(String jobId, String type, File photo) {
    final ref = storage.ref().child('bookings/$jobId/$type.jpg');
    return ref.putFile(photo).then((_) => ref.getDownloadURL());
  }

  @override
  Future<void> collectCash(String jobId, double amount, String handymanId) async {
    final batch = firestore.batch();
    
    // 1. Update booking
    final bookingRef = firestore.collection('bookings').doc(jobId);
    batch.update(bookingRef, {
      'paymentStatus': 'paid',
      'cashCollectedAt': FieldValue.serverTimestamp(),
    });

    // 2. Update handyman wallet
    final walletRef = firestore.collection('wallets').doc(handymanId);
    batch.update(walletRef, {
      'cashCollected': FieldValue.increment(amount),
    });

    // Also update handyman profile doc for consistency
    final handymanRef = firestore.collection('handymen').doc(handymanId);
    batch.update(handymanRef, {
      'cashCollected': FieldValue.increment(amount),
    });

    // 3. Log transaction
    final transactionRef = firestore.collection('transactions').doc();
    batch.set(transactionRef, {
      'userId': handymanId,
      'type': 'cash',
      'amount': amount,
      'bookingId': jobId,
      'status': BookingStatuses.completed,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await batch.commit();
  }
}

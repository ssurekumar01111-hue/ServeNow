import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/features/notifications/domain/entities/notification_entity.dart';

abstract class NotificationsRemoteDataSource {
  Stream<List<NotificationEntity>> getNotifications(String userId);
  Future<void> markAllAsRead(String userId);
}

class NotificationsRemoteDataSourceImpl implements NotificationsRemoteDataSource {
  NotificationsRemoteDataSourceImpl(this.firestore);
  final FirebaseFirestore firestore;

  @override
  Stream<List<NotificationEntity>> getNotifications(String userId) {
    return firestore
        .collection('notifications')
        .doc(userId)
        .collection('items')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return NotificationEntity(
                id: doc.id,
                title: data['title'] as String,
                body: data['body'] as String,
                createdAt: (data['createdAt'] as Timestamp).toDate(),
                isRead: (data['isRead'] as bool?) ?? false,
                data: data['data'] as Map<String, dynamic>?,
              );
            }).toList());
  }

  @override
  Future<void> markAllAsRead(String userId) async {
    final snapshot = await firestore
        .collection('notifications')
        .doc(userId)
        .collection('items')
        .where('isRead', isEqualTo: false)
        .get();
    
    final batch = firestore.batch();
    for (final doc in snapshot.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    await batch.commit();
  }
}

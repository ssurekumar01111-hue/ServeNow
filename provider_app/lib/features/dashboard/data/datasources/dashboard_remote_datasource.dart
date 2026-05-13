import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/features/dashboard/data/models/dashboard_stats.dart';

abstract class DashboardRemoteDataSource {
  Stream<DashboardStats> getStats(String providerId);
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  DashboardRemoteDataSourceImpl(this.firestore);
  final FirebaseFirestore firestore;

  @override
  Stream<DashboardStats> getStats(String providerId) {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    
    return firestore
        .collection('bookings')
        .where('providerId', isEqualTo: providerId)
        .snapshots()
        .map((snapshot) {
      var todayBookings = 0;
      double todayEarnings = 0;
      var pendingBookings = 0;
      
      for (final doc in snapshot.docs) {
        final data = doc.data();
        final status = data['status'] as String;
        final createdAt = (data['createdAt'] as Timestamp).toDate();
        final providerEarning = (data['providerEarning'] as num?)?.toDouble() ?? 0.0;
        
        if (createdAt.isAfter(startOfDay)) {
          todayBookings++;
          if (status == 'completed') {
            todayEarnings += providerEarning;
          }
        }
        
        if (status == 'pending') {
          pendingBookings++;
        }
      }
      
      return DashboardStats(
        todayBookings: todayBookings,
        todayEarnings: todayEarnings,
        averageRating: 0, // Should be fetched from profile
        pendingBookings: pendingBookings,
      );
    });
  }
}

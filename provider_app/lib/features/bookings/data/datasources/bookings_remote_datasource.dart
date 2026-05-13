import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/features/bookings/domain/entities/booking_entity.dart';
import 'package:rxdart/rxdart.dart';

abstract class BookingsRemoteDataSource {
  Stream<List<BookingEntity>> getBookings(String providerId, List<String> categoryIds);
  Future<void> updateBookingStatus(String bookingId, String status);
  Future<void> assignHandyman(String bookingId, String handymanId, String handymanName);
  Future<void> claimBooking(String bookingId, String providerId, String providerName);
}

class BookingsRemoteDataSourceImpl implements BookingsRemoteDataSource {
  BookingsRemoteDataSourceImpl(this.firestore);
  final FirebaseFirestore firestore;

  DateTime _parseTimestamp(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is Timestamp) return value.toDate();
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (_) {
        return DateTime.now();
      }
    }
    return DateTime.now();
  }

  DateTime? _parseOptionalTimestamp(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  BookingEntity _mapDocToEntity(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BookingEntity(
      id: doc.id,
      customerId: (data['customerId'] as String?) ?? '',
      customerName: (data['customerName'] as String?) ?? 'Customer',
      customerPhone: (data['customerPhone'] as String?) ?? '',
      customerAddress: (data['customerAddress'] as String?) ?? '',
      customerArea: (data['customerArea'] as String?) ?? '',
      providerId: (data['providerId'] as String?) ?? '',
      providerName: (data['providerName'] as String?) ?? '',
      assignedHandymanId: data['assignedHandymanId'] as String?,
      assignedHandymanName: data['assignedHandymanName'] as String?,
      serviceId: (data['serviceId'] as String?) ?? '',
      serviceName: (data['serviceName'] as String?) ?? '',
      serviceCategory: (data['serviceCategory'] as String?) ?? '',
      serviceCategoryId: (data['serviceCategoryId'] as String?) ?? '',
      scheduledDate: _parseTimestamp(data['scheduledDate'] ?? data['scheduledAt']),
      scheduledTime: (data['scheduledTime'] as String?) ?? '',
      status: BookingStatus.values.firstWhere(
          (e) => e.name == ((data['status'] as String?) ?? 'pending'),
          orElse: () => BookingStatus.pending),
      otp: (data['otp'] as String?) ?? '',
      amount: ((data['amount'] as num?) ?? 0.0).toDouble(),
      commission: ((data['commission'] as num?) ?? 0.0).toDouble(),
      providerEarning: ((data['providerEarning'] as num?) ?? 0.0).toDouble(),
      handymanEarning: ((data['handymanEarning'] as num?) ?? 0.0).toDouble(),
      handymanCommissionRate: ((data['handymanCommissionRate'] as num?) ?? 0.0).toDouble(),
      paymentMethod: PaymentMethod.values.firstWhere(
          (e) => e.name == ((data['paymentMethod'] as String?) ?? 'cod'),
          orElse: () => PaymentMethod.cod),
      paymentStatus: PaymentStatus.values.firstWhere(
          (e) => e.name == ((data['paymentStatus'] as String?) ?? 'pending'),
          orElse: () => PaymentStatus.pending),
      cancellationReason: data['cancellationReason'] as String?,
      cancelledBy: data['cancelledBy'] as String?,
      couponCode: data['couponCode'] as String?,
      discountAmount: ((data['discountAmount'] as num?) ?? 0.0).toDouble(),
      notes: data['notes'] as String?,
      createdAt: _parseTimestamp(data['createdAt']),
      updatedAt: _parseTimestamp(data['updatedAt']),
      completedAt: _parseOptionalTimestamp(data['completedAt']),
      rating: (data['rating'] as num?)?.toDouble(),
      review: data['review'] as String?,
      autoAssigned: (data['autoAssigned'] as bool?) ?? false,
      autoAssignedAt: _parseOptionalTimestamp(data['autoAssignedAt']),
    );
  }

  @override
  Stream<List<BookingEntity>> getBookings(String providerId, List<String> categoryIds) {
    // Stream 1: Direct bookings
    final assignedStream = firestore
        .collection('bookings')
        .where('providerId', isEqualTo: providerId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(_mapDocToEntity).toList());

    // Stream 2: Broadcast bookings
    // If no categories, return empty stream for broadcast
    Stream<List<BookingEntity>> broadcastStream;
    if (categoryIds.isEmpty) {
      broadcastStream = Stream.value([]);
    } else {
      broadcastStream = firestore
          .collection('bookings')
          .where('providerId', isEqualTo: '')
          .where('serviceCategoryId', whereIn: categoryIds)
          .where('status', isEqualTo: 'pending')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map(_mapDocToEntity).toList());
    }

    return Rx.combineLatest2<List<BookingEntity>, List<BookingEntity>, List<BookingEntity>>(
      assignedStream,
      broadcastStream,
      (assigned, broadcast) {
        final allBookings = [...assigned, ...broadcast];
        
        // Deduplicate by ID
        final Map<String, BookingEntity> deduplicated = {};
        for (var booking in allBookings) {
          deduplicated[booking.id] = booking;
        }
        
        final result = deduplicated.values.toList();
        
        // Sort by createdAt descending
        result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        
        return result;
      },
    );
  }

  @override
  Future<void> updateBookingStatus(String bookingId, String status) async {
    final updateData = {
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
      'statusTimeline.$status': FieldValue.serverTimestamp(),
    };
    
    if (status == 'completed') {
      updateData['completedAt'] = FieldValue.serverTimestamp();
      updateData['paymentStatus'] = 'paid';
      
      final bookingDoc = await firestore.collection('bookings').doc(bookingId).get();
      if (bookingDoc.exists) {
        final data = bookingDoc.data()!;
        final providerId = data['providerId'] as String;
        final providerEarning = (data['providerEarning'] as num).toDouble();
        
        final walletRef = firestore.collection('providers').doc(providerId).collection('wallet').doc('info');
        final transactionRef = firestore.collection('providers').doc(providerId).collection('transactions').doc();
        
        await firestore.runTransaction((transaction) async {
          final walletDoc = await transaction.get(walletRef);
          if (!walletDoc.exists) {
            transaction.set(walletRef, {'totalEarned': providerEarning});
          } else {
            transaction.update(walletRef, {'totalEarned': FieldValue.increment(providerEarning)});
          }
          
          transaction.set(transactionRef, {
            'type': 'earning',
            'amount': providerEarning,
            'bookingId': bookingId,
            'serviceName': data['serviceName'] ?? 'Service',
            'createdAt': FieldValue.serverTimestamp(),
          });
        });
      }
    }
    
    await firestore.collection('bookings').doc(bookingId).update(updateData);
  }

  @override
  Future<void> assignHandyman(String bookingId, String handymanId, String handymanName) async {
    await firestore.collection('bookings').doc(bookingId).update({
      'assignedHandymanId': handymanId,
      'assignedHandymanName': handymanName,
      'status': 'assigned',
      'updatedAt': FieldValue.serverTimestamp(),
      'statusTimeline.assigned': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> claimBooking(String bookingId, String providerId, String providerName) async {
    final bookingRef = firestore.collection('bookings').doc(bookingId);
    
    await firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(bookingRef);
      if (!snapshot.exists) throw Exception('Booking not found');
      
      final currentProviderId = snapshot.data()?['providerId'] as String?;
      if (currentProviderId != null && currentProviderId.isNotEmpty) {
        throw Exception('This booking has already been claimed by another provider');
      }
      
      transaction.update(bookingRef, {
        'providerId': providerId,
        'providerName': providerName,
        'status': 'confirmed',
        'updatedAt': FieldValue.serverTimestamp(),
        'statusTimeline.confirmed': FieldValue.serverTimestamp(),
      });
    });
  }
}

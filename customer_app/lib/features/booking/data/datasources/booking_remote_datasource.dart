import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/features/booking/data/models/booking_model.dart';
import 'package:flutter/foundation.dart';

abstract class BookingRemoteDataSource {
  Future<BookingModel> createBooking(BookingModel booking);
  Stream<List<BookingModel>> getBookings(String uid);
  Stream<BookingModel> getBookingById(String id);
  Future<void> updateBookingStatus(String id, String status);
  Future<void> updateBookingStatusWithReason(String id, String status, String reason, String cancelledBy);
  Future<CouponModel?> getCoupon(String code);
  Future<List<CouponModel>> getAvailableCoupons();
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  BookingRemoteDataSourceImpl(this.firestore);
  final FirebaseFirestore firestore;

  @override
  Future<void> updateBookingStatusWithReason(String id, String status, String reason, String cancelledBy) async {
    await firestore.collection('bookings').doc(id).update({
      'status': status,
      'cancellationReason': reason,
      'cancelledBy': cancelledBy,
      'updatedAt': FieldValue.serverTimestamp(),
      'statusTimeline.$status': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<BookingModel> createBooking(BookingModel booking) async {
    if (kDebugMode) {
      debugPrint('📋 Datasource.createBooking called for customer: ${booking.customerId}');
    }
    try {
      final data = {
        'customerId': booking.customerId,
        'customerName': booking.customerName,
        'customerPhone': booking.customerPhone,
        'customerAddress': booking.customerAddress,
        'customerArea': booking.customerArea,
        'providerId': booking.providerId,
        'providerName': booking.providerName,
        'assignedHandymanId': null,
        'assignedHandymanName': null,
        'serviceId': booking.serviceId,
        'serviceName': booking.serviceName,
        'serviceCategory': booking.serviceCategory,
        'serviceCategoryId': booking.serviceCategoryId,
        'scheduledDate': Timestamp.fromDate(booking.scheduledDate),
        'scheduledTime': booking.scheduledTime,
        'status': booking.status,
        'otp': booking.otp,
        'amount': booking.amount,
        'commission': booking.commission,
        'providerEarning': booking.providerEarning,
        'paymentMethod': booking.paymentMethod,
        'paymentStatus': booking.paymentStatus,
        'couponCode': booking.couponCode,
        'discountAmount': booking.discountAmount,
        'notes': booking.notes,
        'customerLat': booking.customerLat,
        'customerLng': booking.customerLng,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };
      
      final docRef = await firestore.collection('bookings').add(data);
      if (kDebugMode) {
        debugPrint('📋 Booking saved to Firestore with ID: ${docRef.id}');
      }
      return booking.copyWith(id: docRef.id);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('📋 Firestore write FAILED: $e');
      }
      rethrow;
    }
  }

  @override
  Stream<List<BookingModel>> getBookings(String uid) {
    if (kDebugMode) {
      debugPrint('📋 Fetching bookings for customer: $uid');
    }
    return firestore
        .collection('bookings')
        .where('customerId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          if (kDebugMode) {
            debugPrint('📋 Found ${snapshot.docs.length} bookings');
          }
          return snapshot.docs.map(BookingModel.fromFirestore).toList();
        });
  }

  @override
  Stream<BookingModel> getBookingById(String id) {
    return firestore
        .collection('bookings')
        .doc(id)
        .snapshots()
        .map(BookingModel.fromFirestore);
  }

  @override
  Future<void> updateBookingStatus(String id, String status) async {
    await firestore.collection('bookings').doc(id).update({
      'status': status,
      'statusTimeline.$status': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<CouponModel?> getCoupon(String code) async {
    final doc = await firestore.collection('coupons').doc(code).get();
    if (!doc.exists) return null;
    return CouponModel.fromFirestore(doc);
  }

  @override
  Future<List<CouponModel>> getAvailableCoupons() async {
    final snapshot = await firestore
        .collection('coupons')
        .where('isActive', isEqualTo: true)
        .where('expiresAt', isGreaterThan: Timestamp.now())
        .get();
    return snapshot.docs.map(CouponModel.fromFirestore).toList();
  }
}

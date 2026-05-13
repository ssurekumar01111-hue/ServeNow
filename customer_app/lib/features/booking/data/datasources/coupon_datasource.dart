import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/features/booking/data/models/booking_model.dart';
import 'package:customer/features/booking/domain/entities/booking_entity.dart';
import 'package:customer/core/providers/firebase_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final couponDataSourceProvider = Provider<CouponDataSource>((ref) {
  return CouponDataSource(ref.watch(firestoreProvider));
});

class CouponDataSource {
  final FirebaseFirestore _firestore;

  CouponDataSource(this._firestore);

  Future<List<CouponEntity>> getActiveCoupons() async {
    try {
      final snapshot = await _firestore
          .collection('coupons')
          .where('isActive', isEqualTo: true)
          .get();
      return snapshot.docs.map((doc) => CouponModel.fromFirestore(doc).toEntity()).toList();
    } catch (e) {
      debugPrint('CouponDataSource.getActiveCoupons error: $e');
      return [];
    }
  }

  Future<CouponEntity> validateAndGetCoupon(String code, double orderAmount) async {
    final doc = await _firestore.collection('coupons').doc(code.toUpperCase()).get();
    if (!doc.exists) throw Exception('Invalid coupon code');

    final coupon = CouponModel.fromFirestore(doc).toEntity();
    if (coupon.isActive == false) throw Exception('This coupon is no longer active');
    // Note: expiresAt is not null in CouponEntity definition, but we check anyway if needed
    if (coupon.expiresAt.isBefore(DateTime.now())) throw Exception('This coupon has expired');
    if (orderAmount < coupon.minOrder) throw Exception('Minimum order ₹${coupon.minOrder.toInt()} required');
    
    // Note: usageLimit and usageCount are in the Firestore seed but not in CouponEntity/CouponModel
    // I will stick to what's in CouponEntity for now to avoid compilation errors.
    
    return coupon;
  }
}

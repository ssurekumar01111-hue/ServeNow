import 'package:customer/features/booking/data/datasources/coupon_datasource.dart';
import 'package:customer/features/booking/domain/entities/booking_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final availableCouponsProvider = AsyncNotifierProvider<AvailableCouponsNotifier, List<CouponEntity>>(() {
  return AvailableCouponsNotifier();
});

class AvailableCouponsNotifier extends AsyncNotifier<List<CouponEntity>> {
  @override
  Future<List<CouponEntity>> build() async {
    try {
      final coupons = await ref.read(couponDataSourceProvider).getActiveCoupons();
      if (coupons.isEmpty) return _demoCoupons;
      return coupons;
    } catch (e) {
      return _demoCoupons;
    }
  }

  List<CouponEntity> get _demoCoupons => [
    CouponEntity(code: 'FIRST50', discount: 50, type: 'flat', minOrder: 200, maxDiscount: 50, expiresAt: DateTime.now().add(const Duration(days: 365)), isActive: true),
    CouponEntity(code: 'SAVE20', discount: 20, type: 'percentage', minOrder: 300, maxDiscount: 100, expiresAt: DateTime.now().add(const Duration(days: 365)), isActive: true),
    CouponEntity(code: 'WELCOME100', discount: 100, type: 'flat', minOrder: 500, maxDiscount: 100, expiresAt: DateTime.now().add(const Duration(days: 365)), isActive: true),
    CouponEntity(code: 'CLEAN30', discount: 30, type: 'percentage', minOrder: 400, maxDiscount: 150, expiresAt: DateTime.now().add(const Duration(days: 365)), isActive: true),
  ];
}

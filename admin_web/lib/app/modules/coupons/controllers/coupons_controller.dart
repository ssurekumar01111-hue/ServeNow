import 'dart:async';
import 'package:get/get.dart';
import 'package:admin_web/app/models/coupon_model.dart';
import 'package:admin_web/app/utils/fire_store_utils.dart';

class CouponsController extends GetxController {
  final allCoupons = <CouponModel>[].obs;
  final isLoading = true.obs;
  StreamSubscription? _sub;

  @override
  void onInit() {
    super.onInit();
    listenToCoupons();
  }

  void listenToCoupons() {
    _sub = FireStoreUtils.getCouponsStream().listen((snapshot) {
      allCoupons.value = snapshot.docs
          .map((doc) => CouponModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      isLoading.value = false;
    });
  }

  Future<void> saveCoupon(CouponModel coupon) async {
    if (allCoupons.any((c) => c.id == coupon.id)) {
      await FireStoreUtils.updateCoupon(coupon.id!, coupon.toJson());
    } else {
      await FireStoreUtils.addCoupon(coupon);
    }
  }

  Future<void> deleteCoupon(String id) async {
    await FireStoreUtils.deleteCoupon(id);
  }

  Future<void> toggleActive(String id, bool isActive) async {
    await FireStoreUtils.toggleCoupon(id, isActive);
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}

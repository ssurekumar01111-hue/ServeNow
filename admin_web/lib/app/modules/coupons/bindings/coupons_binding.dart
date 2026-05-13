import 'package:get/get.dart';
import 'package:admin_web/app/modules/coupons/controllers/coupons_controller.dart';

class CouponsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CouponsController());
  }
}

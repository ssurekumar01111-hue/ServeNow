import 'package:get/get.dart';
import 'package:admin_web/app/modules/withdrawals/controllers/withdrawals_controller.dart';

class WithdrawalsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WithdrawalsController());
  }
}

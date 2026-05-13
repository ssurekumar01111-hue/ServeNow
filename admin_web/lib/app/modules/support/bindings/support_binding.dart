import 'package:get/get.dart';
import 'package:admin_web/app/modules/support/controllers/support_controller.dart';

class SupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SupportController());
  }
}

import 'package:get/get.dart';
import 'package:admin_web/app/modules/handymen/controllers/handymen_controller.dart';

class HandymenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HandymenController());
  }
}

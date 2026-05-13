import 'package:get/get.dart';
import 'package:admin_web/app/modules/services/controllers/services_controller.dart';

class ServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ServicesController());
  }
}

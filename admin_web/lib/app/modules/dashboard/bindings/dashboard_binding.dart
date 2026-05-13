import 'package:get/get.dart';
import 'package:admin_web/app/modules/dashboard/controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
  }
}

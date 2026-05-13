import 'package:get/get.dart';
import 'package:admin_web/app/modules/admins/controllers/admins_controller.dart';

class AdminsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AdminsController());
  }
}

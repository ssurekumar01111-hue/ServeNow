import 'package:get/get.dart';
import 'package:admin_web/app/modules/login/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}

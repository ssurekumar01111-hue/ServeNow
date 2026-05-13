import 'package:get/get.dart';
import 'package:admin_web/app/modules/splash/controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}

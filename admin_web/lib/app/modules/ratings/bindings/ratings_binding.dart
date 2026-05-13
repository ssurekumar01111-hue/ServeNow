import 'package:get/get.dart';
import 'package:admin_web/app/modules/ratings/controllers/ratings_controller.dart';

class RatingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RatingsController());
  }
}

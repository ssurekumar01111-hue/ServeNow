import 'package:get/get.dart';
import 'package:admin_web/app/modules/analytics/controllers/analytics_controller.dart';

class AnalyticsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AnalyticsController());
  }
}

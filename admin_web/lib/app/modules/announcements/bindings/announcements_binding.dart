import 'package:get/get.dart';
import 'package:admin_web/app/modules/announcements/controllers/announcements_controller.dart';

class AnnouncementsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AnnouncementsController());
  }
}

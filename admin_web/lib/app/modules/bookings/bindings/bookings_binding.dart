import 'package:get/get.dart';
import '../controllers/bookings_controller.dart';

class BookingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BookingsController());
  }
}

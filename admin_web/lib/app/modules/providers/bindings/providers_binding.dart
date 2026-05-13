import 'package:get/get.dart';
import '../controllers/providers_controller.dart';

class ProvidersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProvidersController());
  }
}

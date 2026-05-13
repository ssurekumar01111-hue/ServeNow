import 'package:get/get.dart';
import 'package:admin_web/app/modules/categories/controllers/categories_controller.dart';

class CategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CategoriesController());
  }
}

import 'package:get/get.dart';
import '../controllers/provider_approvals_controller.dart';

class ProviderApprovalsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProviderApprovalsController>(
      () => ProviderApprovalsController(),
      tag: 'approvals',
      fenix: true,
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:admin_web/app/routes/app_pages.dart';
import 'package:admin_web/app/utils/fire_store_utils.dart';
import 'package:admin_web/app/constants/app_constants.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      final user = FirebaseAuth.instance.currentUser;
      
      if (user == null) {
        Get.offAllNamed(Routes.LOGIN);
      } else {
        bool exists = await FireStoreUtils.adminExistsInFirestore(user.uid);
        if (exists) {
          AppConstants.adminModel = await FireStoreUtils.getAdminProfile(user.uid);
          Get.offAllNamed(Routes.DASHBOARD);
        } else {
          await FirebaseAuth.instance.signOut();
          Get.offAllNamed(Routes.LOGIN);
        }
      }
    } catch (e) {
      print("Splash error: $e");
      // If something crashes, at least go to login
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}

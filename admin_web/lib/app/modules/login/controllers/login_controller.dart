import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_web/app/routes/app_pages.dart';
import 'package:admin_web/app/utils/fire_store_utils.dart';
import 'package:admin_web/app/constants/app_constants.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;
  final obscurePassword = true.obs;

  Future<void> login() async {
    if (emailController.text.trim().isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter email and password',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    EasyLoading.show(status: 'Logging in...');

    try {
      UserCredential cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      bool exists = await FireStoreUtils.adminExistsInFirestore(cred.user!.uid);
      if (exists) {
        AppConstants.adminModel = await FireStoreUtils.getAdminProfile(cred.user!.uid);
        Get.offAllNamed(Routes.DASHBOARD);
      } else {
        await FirebaseAuth.instance.signOut();
        Get.snackbar('Access Denied', 'Not an admin account',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
      EasyLoading.dismiss();
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

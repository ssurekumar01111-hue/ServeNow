import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_web/app/modules/splash/controllers/splash_controller.dart';
import 'package:admin_web/app/utils/app_colors.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.sidebarBg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.home_repair_service,
                size: 80,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'ServeNow',
              style: TextStyle(
                color: Colors.white,
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Admin Panel',
              style: TextStyle(
                color: AppColors.sidebarText,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 60),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

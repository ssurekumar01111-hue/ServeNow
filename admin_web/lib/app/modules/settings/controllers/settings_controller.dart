import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_web/app/utils/fire_store_utils.dart';

class SettingsController extends GetxController {
  final isLoading = true.obs;
  final isSaving = false.obs;

  final defaultCommission = 10.0.obs;
  final minBookingAmount = 0.0.obs;
  final cancellationWindowMinutes = 30.obs;
  final cancellationFeePercent = 0.0.obs;
  final maxServiceAreasPerProvider = 10.obs;
  final maxHandymenPerProvider = 20.obs;
  final platformName = 'ServeNow'.obs;
  final supportPhone = ''.obs;
  final supportEmail = ''.obs;
  final termsUrl = ''.obs;
  final privacyUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  Future<void> loadSettings() async {
    isLoading.value = true;
    try {
      final data = await FireStoreUtils.getPlatformSettings();
      if (data != null) {
        defaultCommission.value = (data['defaultCommission'] ?? 10.0).toDouble();
        minBookingAmount.value = (data['minBookingAmount'] ?? 0.0).toDouble();
        cancellationWindowMinutes.value = data['cancellationWindowMinutes'] ?? 30;
        cancellationFeePercent.value = (data['cancellationFeePercent'] ?? 0.0).toDouble();
        maxServiceAreasPerProvider.value = data['maxServiceAreasPerProvider'] ?? 10;
        maxHandymenPerProvider.value = data['maxHandymenPerProvider'] ?? 20;
        platformName.value = data['platformName'] ?? 'ServeNow';
        supportPhone.value = data['supportPhone'] ?? '';
        supportEmail.value = data['supportEmail'] ?? '';
        termsUrl.value = data['termsUrl'] ?? '';
        privacyUrl.value = data['privacyUrl'] ?? '';
      }
    } catch (e) {
      print('Error loading settings: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveSettings() async {
    isSaving.value = true;
    try {
      final data = {
        'defaultCommission': defaultCommission.value,
        'minBookingAmount': minBookingAmount.value,
        'cancellationWindowMinutes': cancellationWindowMinutes.value,
        'cancellationFeePercent': cancellationFeePercent.value,
        'maxServiceAreasPerProvider': maxServiceAreasPerProvider.value,
        'maxHandymenPerProvider': maxHandymenPerProvider.value,
        'platformName': platformName.value,
        'supportPhone': supportPhone.value,
        'supportEmail': supportEmail.value,
        'termsUrl': termsUrl.value,
        'privacyUrl': privacyUrl.value,
      };
      await FireStoreUtils.updatePlatformSettings(data);
      Get.snackbar('Success', 'Settings saved successfully', backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Error', 'Failed to save settings: $e', backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isSaving.value = false;
    }
  }
}

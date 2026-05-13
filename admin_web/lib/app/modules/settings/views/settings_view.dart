import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_web/app/modules/settings/controllers/settings_controller.dart';
import 'package:admin_web/widgets/main_layout.dart';
import 'package:admin_web/app/utils/app_colors.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Platform Settings',
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _buildCommissionCard(),
                      const SizedBox(height: 24),
                      _buildProviderLimitsCard(),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    children: [
                      _buildPlatformInfoCard(),
                      const SizedBox(height: 24),
                      _buildLegalLinksCard(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: controller.isSaving.value ? null : controller.saveSettings,
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
                child: controller.isSaving.value 
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('Save All Settings', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildCard({required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          ...children,
        ],
      ),
    );
  }

  Widget _buildCommissionCard() {
    return _buildCard(
      title: 'Commission & Fees',
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Default Commission (%)', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('${controller.defaultCommission.value}%', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          ],
        ),
        Slider(
          value: controller.defaultCommission.value,
          min: 0,
          max: 30,
          divisions: 30,
          activeColor: AppColors.primary,
          onChanged: (val) => controller.defaultCommission.value = val,
        ),
        const SizedBox(height: 16),
        _buildTextField('Minimum Booking Amount (₹)', controller.minBookingAmount.value.toString(), (val) => controller.minBookingAmount.value = double.tryParse(val) ?? 0, keyboardType: TextInputType.number),
        const SizedBox(height: 16),
        _buildTextField('Cancellation Window (Minutes)', controller.cancellationWindowMinutes.value.toString(), (val) => controller.cancellationWindowMinutes.value = int.tryParse(val) ?? 0, keyboardType: TextInputType.number),
        const SizedBox(height: 16),
        _buildTextField('Cancellation Fee (%)', controller.cancellationFeePercent.value.toString(), (val) => controller.cancellationFeePercent.value = double.tryParse(val) ?? 0, keyboardType: TextInputType.number),
      ],
    );
  }

  Widget _buildProviderLimitsCard() {
    return _buildCard(
      title: 'Provider Limits',
      children: [
        _buildTextField('Max Service Areas per Provider', controller.maxServiceAreasPerProvider.value.toString(), (val) => controller.maxServiceAreasPerProvider.value = int.tryParse(val) ?? 0, keyboardType: TextInputType.number),
        const SizedBox(height: 16),
        _buildTextField('Max Handymen per Provider', controller.maxHandymenPerProvider.value.toString(), (val) => controller.maxHandymenPerProvider.value = int.tryParse(val) ?? 0, keyboardType: TextInputType.number),
      ],
    );
  }

  Widget _buildPlatformInfoCard() {
    return _buildCard(
      title: 'Platform Information',
      children: [
        _buildTextField('Platform Name', controller.platformName.value, (val) => controller.platformName.value = val),
        const SizedBox(height: 16),
        _buildTextField('Support Phone Number', controller.supportPhone.value, (val) => controller.supportPhone.value = val, keyboardType: TextInputType.phone),
        const SizedBox(height: 16),
        _buildTextField('Support Email Address', controller.supportEmail.value, (val) => controller.supportEmail.value = val, keyboardType: TextInputType.emailAddress),
      ],
    );
  }

  Widget _buildLegalLinksCard() {
    return _buildCard(
      title: 'Legal Links',
      children: [
        _buildTextField('Terms & Conditions URL', controller.termsUrl.value, (val) => controller.termsUrl.value = val, keyboardType: TextInputType.url),
        const SizedBox(height: 16),
        _buildTextField('Privacy Policy URL', controller.privacyUrl.value, (val) => controller.privacyUrl.value = val, keyboardType: TextInputType.url),
      ],
    );
  }

  Widget _buildTextField(String label, String initialValue, Function(String) onChanged, {TextInputType? keyboardType}) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      keyboardType: keyboardType,
      onChanged: onChanged,
    );
  }
}

import 'dart:async';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:admin_web/app/models/provider_model.dart';
import 'package:admin_web/app/utils/fire_store_utils.dart';

class ProviderApprovalsController extends GetxController {
  RxList<ProviderModel> pendingProviders = <ProviderModel>[].obs;
  RxList<ProviderModel> allProviders = <ProviderModel>[].obs;
  RxInt pendingCount = 0.obs;
  RxBool isLoading = true.obs;
  StreamSubscription? _sub;

  @override
  void onInit() {
    super.onInit();
    listenToProviders();
  }

  void listenToProviders() {
    _sub = FirebaseFirestore.instance
      .collection('providers')
      .snapshots()
      .listen(
        (snapshot) {
          print('Provider approvals snapshot: ${snapshot.docs.length} docs');

          final all = snapshot.docs.map((doc) {
            final data = Map<String, dynamic>.from(doc.data());
            // Always set id from document ID
            data['id'] = doc.id;
            data['uid'] = doc.id;
            print('Provider ${doc.id}: status=${data['onboardingStatus']}');
            return ProviderModel.fromJson(data);
          }).toList();

          allProviders.value = all;

          // Filter only pending_approval
          pendingProviders.value = all
            .where((p) => p.onboardingStatus == 'pending_approval')
            .toList();

          pendingCount.value = pendingProviders.length;
          isLoading.value = false;
          update();
        },
        onError: (e) {
          print('Provider approvals error: $e');
          isLoading.value = false;
          update();
        },
      );
  }

  Future<void> approveProvider(ProviderModel provider) async {
    try {
      isLoading.value = true;
      final adminUid = FirebaseAuth.instance.currentUser?.uid ?? '';

      await FirebaseFirestore.instance
        .collection('providers')
        .doc(provider.id)
        .update({
          'onboardingStatus': 'approved',
          'isActive': true,
          'commissionRate': 10.0,
          'approvedAt': FieldValue.serverTimestamp(),
          'approvedBy': adminUid,
          'updatedAt': FieldValue.serverTimestamp(),
        });

      // Send FCM to provider
      if (provider.fcmToken.isNotEmpty) {
        await FireStoreUtils.sendFCMToToken(
          token: provider.fcmToken,
          title: 'Account Approved!',
          body: 'Welcome to ServeNow! You can now accept bookings.',
          data: {'type': 'account_approved'},
        );
      }

      EasyLoading.showSuccess('${provider.businessName} approved!');
      isLoading.value = false;
      update();
    } catch (e) {
      print('Approve error: $e');
      EasyLoading.showError('Error approving provider: $e');
      isLoading.value = false;
      update();
    }
  }

  Future<void> rejectProvider(ProviderModel provider, String reason) async {
    try {
      await FirebaseFirestore.instance
        .collection('providers')
        .doc(provider.id)
        .update({
          'onboardingStatus': 'rejected',
          'isActive': false,
          'rejectionReason': reason,
          'updatedAt': FieldValue.serverTimestamp(),
        });

      if (provider.fcmToken.isNotEmpty) {
        await FireStoreUtils.sendFCMToToken(
          token: provider.fcmToken,
          title: 'Application Update',
          body: 'Your application needs attention. Please check the app for details.',
          data: {'type': 'account_rejected'},
        );
      }

      EasyLoading.showSuccess('Provider rejected.');
      update();
    } catch (e) {
      EasyLoading.showError('Error: $e');
      update();
    }
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}

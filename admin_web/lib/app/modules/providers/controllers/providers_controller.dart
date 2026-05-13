import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin_web/app/models/provider_model.dart';
import 'package:admin_web/app/utils/fire_store_utils.dart';

class ProvidersController extends GetxController {
  var allProviders = <ProviderModel>[].obs;
  var filteredProviders = <ProviderModel>[].obs;
  var searchQuery = ''.obs;
  var statusFilter = 'All'.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    listenToProviders();
  }

  void listenToProviders() {
    isLoading.value = true;
    FirebaseFirestore.instance
      .collection('providers')
      .where('onboardingStatus', isEqualTo: 'approved')
      .snapshots()
      .listen((snapshot) {
        allProviders.value = snapshot.docs.map((doc) {
          final data = Map<String, dynamic>.from(doc.data());
          data['id'] = doc.id;
          data['uid'] = doc.id;
          return ProviderModel.fromJson(data);
        }).toList();
        applyFilters();
        isLoading.value = false;
      });
  }

  void applyFilters() {
    var filtered = allProviders.where((provider) {
      bool matchesSearch = searchQuery.value.isEmpty ||
          provider.businessName
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase());
      bool matchesStatus = statusFilter.value == 'All' ||
          (statusFilter.value == 'Active' && provider.isActive) ||
          (statusFilter.value == 'Inactive' && !provider.isActive);
      return matchesSearch && matchesStatus;
    }).toList();
    filteredProviders.value = filtered;
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  void updateStatusFilter(String status) {
    statusFilter.value = status;
    applyFilters();
  }

  Future<void> updateCommission(String id, double rate) async {
    await FireStoreUtils.updateProviderCommission(id, rate);
  }

  Future<void> toggleActive(String id, bool isActive) async {
    await FireStoreUtils.toggleProviderActive(id, isActive);
  }
}

import 'package:get/get.dart';
import 'package:admin_web/app/models/customer_model.dart';
import 'package:admin_web/app/utils/fire_store_utils.dart';

class CustomersController extends GetxController {
  var allCustomers = <CustomerModel>[].obs;
  var filteredCustomers = <CustomerModel>[].obs;
  var searchQuery = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCustomers();
  }

  void fetchCustomers() {
    isLoading.value = true;
    FireStoreUtils.getCustomersStream().listen((snapshot) {
      allCustomers.value = snapshot.docs
          .map((doc) => CustomerModel.fromJson(doc.data() as Map<String, dynamic>))
          .where((customer) => customer.isDeleted == false)
          .toList();
      applyFilters();
      isLoading.value = false;
    });
  }

  void applyFilters() {
    var filtered = allCustomers.where((customer) {
      bool matchesSearch = searchQuery.value.isEmpty || 
          (customer.fullName?.toLowerCase().contains(searchQuery.value.toLowerCase()) ?? false) ||
          (customer.email?.toLowerCase().contains(searchQuery.value.toLowerCase()) ?? false);
      return matchesSearch;
    }).toList();
    filteredCustomers.value = filtered;
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  Future<void> blockCustomer(String id, bool block) async {
    await FireStoreUtils.blockCustomer(id, block);
  }

  Future<void> deleteCustomer(String id) async {
    await FireStoreUtils.deleteCustomer(id);
  }
}

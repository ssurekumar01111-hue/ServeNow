import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_web/app/models/booking_model.dart';
import 'package:admin_web/app/utils/fire_store_utils.dart';
import 'package:admin_web/app/utils/app_colors.dart';

class BookingsController extends GetxController {
  var allBookings = <BookingModel>[].obs;
  var filteredBookings = <BookingModel>[].obs;
  var statusFilter = 'All'.obs;
  var searchQuery = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBookings();
  }

  void fetchBookings() {
    isLoading.value = true;
    FireStoreUtils.getBookingsStream().listen((snapshot) {
      allBookings.value = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        // Ensure id is populated from document ID if not in data
        if (data['id'] == null) {
          data['id'] = doc.id;
        }
        return BookingModel.fromJson(data);
      }).toList();
      applyFilters();
      isLoading.value = false;
    });
  }

  void applyFilters() {
    var filtered = allBookings.where((booking) {
      bool matchesStatus = statusFilter.value == 'All' || booking.status == statusFilter.value.toLowerCase();
      bool matchesSearch = searchQuery.value.isEmpty || 
          (booking.id?.toLowerCase().contains(searchQuery.value.toLowerCase()) ?? false) ||
          (booking.customerId?.toLowerCase().contains(searchQuery.value.toLowerCase()) ?? false);
      return matchesStatus && matchesSearch;
    }).toList();
    filteredBookings.value = filtered;
  }

  void updateStatusFilter(String status) {
    statusFilter.value = status;
    applyFilters();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  Future<void> updateBookingStatus(String id, String status, String note) async {
    try {
      print('Updating booking: $id to status: $status');
      await FireStoreUtils.updateBookingStatus(id, status, note: note);
      Get.snackbar('Success', 'Booking updated successfully', 
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print('Update error: $e');
      Get.snackbar('Error', 'Failed to update booking: $e', 
          snackPosition: SnackPosition.BOTTOM, backgroundColor: AppColors.error, colorText: Colors.white);
    }
  }

  Future<void> addAdminNote(String id, String note) async {
    try {
      await FireStoreUtils.addAdminNote(id, note);
      Get.snackbar('Success', 'Note added successfully', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to add note: $e', snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> cancelBooking(String id, String reason) async {
    await FireStoreUtils.cancelBooking(id, reason, 'Admin');
  }
}

import 'dart:async';
import 'package:get/get.dart';
import 'package:admin_web/app/utils/fire_store_utils.dart';
import 'package:admin_web/app/models/chart_data.dart';

class DashboardController extends GetxController {
  final totalBookings = 0.obs;
  final pendingBookings = 0.obs;
  final todayRevenue = 0.0.obs;
  final activeBookings = 0.obs;
  final totalCustomers = 0.obs;
  final totalProviders = 0.obs;
  final totalHandymen = 0.obs;
  final isLoading = true.obs;
  final recentBookings = [].obs;
  
  final weeklyRevenue = <ChartData>[].obs;
  final bookingsByStatus = <ChartData>[].obs;
  
  StreamSubscription? bookingSubscription;

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
    listenToLiveBookings();
    _runInitializationTasks();
  }

  Future<void> _runInitializationTasks() async {
    await FireStoreUtils.seedDefaultCategories();
  }

  Future<void> loadDashboardData() async {
    isLoading.value = true;
    try {
      final results = await Future.wait([
        FireStoreUtils.countBookings().catchError((e) => 0),
        FireStoreUtils.getTodayRevenue().catchError((e) => 0.0),
        FireStoreUtils.countCustomers().catchError((e) => 0),
        FireStoreUtils.countProviders().catchError((e) => 0),
        FireStoreUtils.countHandymen().catchError((e) => 0),
      ]);

      totalBookings.value = results[0] as int;
      todayRevenue.value = results[1] as double;
      totalCustomers.value = results[2] as int;
      totalProviders.value = results[3] as int;
      totalHandymen.value = results[4] as int;

      // Mock weekly revenue for now
      weeklyRevenue.value = [
        ChartData('Mon', 1200),
        ChartData('Tue', 1500),
        ChartData('Wed', 1100),
        ChartData('Thu', 1800),
        ChartData('Fri', 2100),
        ChartData('Sat', 2500),
        ChartData('Sun', 2300),
      ];

      bookingsByStatus.value = [
        ChartData('Pending', 15),
        ChartData('In Progress', 25),
        ChartData('Completed', 45),
        ChartData('Cancelled', 10),
      ];

    } catch (e) {
      print('Error loading dashboard data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void listenToLiveBookings() {
    try {
      bookingSubscription = FireStoreUtils.getBookingsStream().listen((snapshot) {
        int pending = 0;
        int active = 0;
        List recent = [];
        
        for (var i = 0; i < snapshot.docs.length; i++) {
          final data = snapshot.docs[i].data() as Map<String, dynamic>;
          data['id'] = snapshot.docs[i].id; // Ensure ID is present
          
          final status = data['status']?.toString().toLowerCase() ?? 'unknown';
          
          if (status == 'pending') pending++;
          if (status != 'completed' && status != 'cancelled') active++;
          
          if (recent.length < 10) {
            recent.add(data);
          }
        }
        
        pendingBookings.value = pending;
        activeBookings.value = active;
        recentBookings.value = recent;
      }, onError: (e) {
        print('Error in bookings stream: $e');
      });
    } catch (e) {
      print('Failed to listen to bookings: $e');
    }
  }

  @override
  void onClose() {
    bookingSubscription?.cancel();
    super.onClose();
  }
}

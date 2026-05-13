import 'package:get/get.dart';
import 'package:admin_web/app/models/chart_data.dart';
import 'package:admin_web/app/utils/fire_store_utils.dart';

class AnalyticsController extends GetxController {
  final dateRange = '30'.obs;
  final isLoading = true.obs;

  final totalRevenue = 0.0.obs;
  final thisMonthRevenue = 0.0.obs;
  final thisWeekRevenue = 0.0.obs;
  final pendingPayouts = 0.0.obs;

  final dailyRevenue = <ChartData>[].obs;
  final revenueByCategory = <ChartData>[].obs;
  final topProviders = <Map<String, dynamic>>[].obs;
  final bookingsByStatus = <ChartData>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAnalytics();
  }

  Future<void> loadAnalytics() async {
    isLoading.value = true;
    try {
      int days = int.tryParse(dateRange.value) ?? 30;
      final now = DateTime.now();
      final start = now.subtract(Duration(days: days));

      final dailyData = await FireStoreUtils.getDailyRevenue(start, now);
      dailyRevenue.value = dailyData.map((e) => ChartData(e['date'], e['revenue'])).toList();

      final catData = await FireStoreUtils.getRevenueByCategory();
      revenueByCategory.value = catData.entries.map((e) => ChartData(e.key, e.value)).toList();

      final topProvData = await FireStoreUtils.getTopProviders();
      topProviders.value = topProvData;

      // Mocked data for demonstration
      totalRevenue.value = 154000.0;
      thisMonthRevenue.value = 45000.0;
      thisWeekRevenue.value = 12000.0;
      pendingPayouts.value = 8500.0;

      bookingsByStatus.value = [
        ChartData('Pending', 15),
        ChartData('In Progress', 25),
        ChartData('Completed', 45),
        ChartData('Cancelled', 10),
      ];
    } catch (e) {
      Get.snackbar('Error', 'Failed to load analytics: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void setDateRange(String range) {
    dateRange.value = range;
    loadAnalytics();
  }
}

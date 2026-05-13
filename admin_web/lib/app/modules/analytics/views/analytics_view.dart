import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_web/app/modules/analytics/controllers/analytics_controller.dart';
import 'package:admin_web/widgets/main_layout.dart';
import 'package:admin_web/widgets/stat_card_widget.dart';
import 'package:admin_web/app/utils/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:admin_web/app/models/chart_data.dart';

class AnalyticsView extends GetView<AnalyticsController> {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Analytics & Reports',
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildStatsRow(),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _buildDailyRevenueChart()),
                const SizedBox(width: 24),
                Expanded(flex: 1, child: _buildCategoryRevenueChart()),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 1, child: _buildTopProvidersChart()),
                const SizedBox(width: 24),
                Expanded(flex: 1, child: _buildBookingsStatusChart()),
              ],
            ),
          ],
        );
      }),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text('Time Range:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 16),
            Obx(() => DropdownButton<String>(
              value: controller.dateRange.value,
              items: const [
                DropdownMenuItem(value: '7', child: Text('Last 7 Days')),
                DropdownMenuItem(value: '30', child: Text('Last 30 Days')),
                DropdownMenuItem(value: '90', child: Text('Last 90 Days')),
              ],
              onChanged: (val) => controller.setDateRange(val!),
            )),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.download),
          label: const Text('Export CSV'),
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return GridView.count(
      crossAxisCount: 4,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.2,
      children: [
        StatCard(title: 'Total Revenue', value: '₹${controller.totalRevenue.value.toStringAsFixed(2)}', icon: Icons.account_balance_wallet, color1: AppColors.statBlue1, color2: AppColors.statBlue2),
        StatCard(title: 'This Month', value: '₹${controller.thisMonthRevenue.value.toStringAsFixed(2)}', icon: Icons.calendar_month, color1: AppColors.statGreen1, color2: AppColors.statGreen2),
        StatCard(title: 'This Week', value: '₹${controller.thisWeekRevenue.value.toStringAsFixed(2)}', icon: Icons.view_week, color1: AppColors.statPurple1, color2: AppColors.statPurple2),
        StatCard(title: 'Pending Payouts', value: '₹${controller.pendingPayouts.value.toStringAsFixed(2)}', icon: Icons.pending_actions, color1: AppColors.statOrange1, color2: AppColors.statOrange2),
      ],
    );
  }

  Widget _buildDailyRevenueChart() {
    return _buildChartContainer(
      title: 'Daily Revenue',
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<ChartData, String>>[
          AreaSeries<ChartData, String>(
            dataSource: controller.dailyRevenue,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            color: AppColors.primaryLight,
            borderColor: AppColors.primary,
            borderWidth: 2,
          )
        ],
      ),
    );
  }

  Widget _buildCategoryRevenueChart() {
    return _buildChartContainer(
      title: 'Revenue by Category',
      child: SfCircularChart(
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CircularSeries>[
          DoughnutSeries<ChartData, String>(
            dataSource: controller.revenueByCategory,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          )
        ],
      ),
    );
  }

  Widget _buildTopProvidersChart() {
    final List<ChartData> topProvidersChartData = controller.topProviders.map((p) {
      return ChartData(p['businessName'] ?? 'Unknown', (p['totalEarnings'] ?? 0).toDouble());
    }).toList();

    return _buildChartContainer(
      title: 'Top 10 Providers',
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        primaryYAxis: const NumericAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<ChartData, String>>[
          BarSeries<ChartData, String>(
            dataSource: topProvidersChartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            color: AppColors.success,
          )
        ],
      ),
    );
  }

  Widget _buildBookingsStatusChart() {
    return _buildChartContainer(
      title: 'Bookings by Status',
      child: SfCircularChart(
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        series: <CircularSeries>[
          DoughnutSeries<ChartData, String>(
            dataSource: controller.bookingsByStatus,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            innerRadius: '60%',
          )
        ],
      ),
    );
  }

  Widget _buildChartContainer({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          SizedBox(height: 300, child: child),
        ],
      ),
    );
  }
}

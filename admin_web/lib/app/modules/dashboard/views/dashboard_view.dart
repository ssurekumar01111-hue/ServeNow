import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_web/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:admin_web/app/utils/app_colors.dart';
import 'package:admin_web/widgets/main_layout.dart';
import 'package:admin_web/widgets/stat_card_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:admin_web/app/models/chart_data.dart';
import 'package:intl/intl.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Dashboard',
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildStatCards(),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _buildRevenueChart()),
                const SizedBox(width: 24),
                Expanded(flex: 1, child: _buildStatusChart()),
              ],
            ),
            const SizedBox(height: 24),
            _buildRecentBookings(),
          ],
        );
      }),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dashboard Overview',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              'Welcome back! Here\'s what\'s happening today.',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () => controller.loadDashboardData(),
          icon: const Icon(Icons.refresh),
          label: const Text('Refresh Data'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCards() {
    return GridView.count(
      crossAxisCount: 4,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.2,
      children: [
        StatCard(
          title: 'Total Bookings',
          value: controller.totalBookings.value.toString(),
          icon: Icons.calendar_today,
          color1: AppColors.statBlue1,
          color2: AppColors.statBlue2,
        ),
        StatCard(
          title: 'Today Revenue',
          value: '₹${controller.todayRevenue.value.toStringAsFixed(2)}',
          icon: Icons.payments_outlined,
          color1: AppColors.statGreen1,
          color2: AppColors.statGreen2,
        ),
        StatCard(
          title: 'Pending Jobs',
          value: controller.pendingBookings.value.toString(),
          icon: Icons.pending_actions,
          color1: AppColors.statOrange1,
          color2: AppColors.statOrange2,
        ),
        StatCard(
          title: 'Active Workers',
          value: controller.totalHandymen.value.toString(),
          icon: Icons.engineering_outlined,
          color1: AppColors.statPurple1,
          color2: AppColors.statPurple2,
        ),
      ],
    );
  }

  Widget _buildRevenueChart() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Revenue Over Time',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 300,
            child: SfCartesianChart(
              primaryXAxis: const CategoryAxis(),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries<ChartData, String>>[
                SplineSeries<ChartData, String>(
                  dataSource: controller.weeklyRevenue,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  color: AppColors.primary,
                  width: 4,
                  markerSettings: const MarkerSettings(isVisible: true),
                  enableTooltip: true,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChart() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Booking Status',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 300,
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
          ),
        ],
      ),
    );
  }

  Widget _buildRecentBookings() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Bookings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          if (controller.recentBookings.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(child: Text('No bookings found')),
            )
          else
            SizedBox(
              width: double.infinity,
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(AppColors.background),
                columns: const [
                  DataColumn(label: Text('Booking ID')),
                  DataColumn(label: Text('Customer')),
                  DataColumn(label: Text('Service')),
                  DataColumn(label: Text('Amount')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Date')),
                ],
                rows: controller.recentBookings.map((booking) {
                  final id = booking['id']?.toString() ?? 'Unknown';
                  final displayId = id.length > 8 ? id.substring(0, 8) : id;
                  
                  return DataRow(cells: [
                    DataCell(Text('#$displayId', style: const TextStyle(fontFamily: 'monospace'))),
                    DataCell(Text(booking['customerName']?.toString() ?? 'Unknown')),
                    DataCell(Text(booking['serviceName']?.toString() ?? 'N/A')),
                    DataCell(Text('₹${booking['amount'] ?? 0.0}')),
                    DataCell(_buildStatusChip(booking['status']?.toString() ?? 'unknown')),
                    DataCell(Text(booking['createdAt'] is Timestamp 
                        ? DateFormat('dd MMM yyyy').format((booking['createdAt'] as Timestamp).toDate())
                        : 'N/A')),
                  ]);
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'completed':
        color = AppColors.success;
        break;
      case 'pending':
        color = AppColors.pending;
        break;
      case 'cancelled':
        color = AppColors.error;
        break;
      default:
        color = AppColors.info;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

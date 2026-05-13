import 'package:handyman/core/constants/booking_status.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:handyman/core/router/app_routes.dart';
import 'package:handyman/core/theme/app_colors.dart';
import 'package:handyman/features/jobs/data/models/booking_model.dart';
import 'package:handyman/features/jobs/domain/entities/job_entity.dart';
import 'package:handyman/features/jobs/presentation/providers/jobs_providers.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:handyman/core/utils/navigation_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JobDetailScreen extends ConsumerWidget {
  const JobDetailScreen({required this.jobId, super.key});
  final String jobId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsAsync = ref.watch(jobsProvider);
    final job = jobsAsync.value?.where((j) => j.id == jobId).firstOrNull;

    if (job == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Job not found.')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context, job),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInUp(child: _buildCustomerCard(context, job)),
                  const SizedBox(height: 20),
                  FadeInUp(delay: const Duration(milliseconds: 100), child: _buildLocationCard(job)),
                  const SizedBox(height: 20),
                  FadeInUp(delay: const Duration(milliseconds: 200), child: _buildNotesCard(job)),
                  const SizedBox(height: 120), // Space for action button
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: _buildBottomAction(context, ref, job),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, BookingModel job) {
    return SliverAppBar(
      expandedHeight: 200.0,
      pinned: true,
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          job.serviceName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            fontSize: 18,
          ),
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AppColors.primaryGradient,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.handyman_outlined, color: Colors.white54, size: 60),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    job.status.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.chat_bubble_outline),
          onPressed: () => context.push(AppRoutes.chatPath(job.id)),
        ),
      ],
    );
  }

  Widget _buildCustomerCard(BuildContext context, BookingModel job) {
    final scheduledDate = job.scheduledDate?.toDate() ?? DateTime.now();
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Customer Details",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: const Icon(Icons.person, color: AppColors.primary),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.customerName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Text(
                        "Scheduled for ${DateFormat('dd MMM, hh:mm a').format(scheduledDate)}",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => _showCallDialog(context, job.customerName, job.customerPhone),
                  icon: const Icon(Icons.call, color: AppColors.primary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard(BookingModel job) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (job.customerLat != 0 && job.customerLng != 0)
            SizedBox(
              height: 180,
              width: double.infinity,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(job.customerLat, job.customerLng),
                  zoom: 15,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('customer'),
                    position: LatLng(job.customerLat, job.customerLng),
                  ),
                },
                liteModeEnabled: true,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Service Location",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () => navigateToCustomer(job),
                      icon: const Icon(Icons.navigation_outlined, size: 16),
                      label: const Text("Navigate"),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on, color: AppColors.error, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        job.customerAddress,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade800,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesCard(BookingModel job) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Service Notes",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 12),
            Text(
              job.notes ?? "No additional notes from customer.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                fontStyle: job.notes == null ? FontStyle.italic : FontStyle.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context, WidgetRef ref, BookingModel job) {
    if (job.status == BookingStatuses.completed || job.status == BookingStatuses.cancelled) {
      return const SizedBox.shrink();
    }

    String label = "";
    Color color = AppColors.primary;
    VoidCallback? onPressed;

    switch (job.status) {
      case BookingStatuses.assigned:
        label = "Start Journey";
        color = AppColors.info;
        onPressed = () => ref.read(jobStatusProvider.notifier).updateStatus(job.id, JobStatus.enRoute);
        break;
      case BookingStatuses.enRoute:
        label = "I Have Arrived";
        color = AppColors.warning;
        onPressed = () => ref.read(jobStatusProvider.notifier).updateStatus(job.id, JobStatus.arrived);
        break;
      case BookingStatuses.arrived:
        label = "Enter Customer OTP";
        color = AppColors.secondary;
        onPressed = () => context.push(AppRoutes.otpVerifyJobPath(job.id));
        break;
      case BookingStatuses.inProgress:
        label = "Complete Job";
        color = AppColors.success;
        onPressed = () => _onCompleteJobTapped(context, ref, job);
        break;
      default:
        return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _onCompleteJobTapped(BuildContext context, WidgetRef ref, BookingModel job) {
    final isCOD = job.paymentMethod == 'cod' || job.paymentMethod == 'cash';
    final alreadyPaid = job.paymentStatus == 'paid' || job.paymentStatus == 'true';

    if (isCOD && !alreadyPaid) {
      _showCashCollectionDialog(context, ref, job);
    } else {
      _showPhotoCaptureSheet(context, ref, job);
    }
  }

  void _showCashCollectionDialog(BuildContext context, WidgetRef ref, BookingModel job) {
    final amount = job.amount;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.payments_outlined, color: Colors.green, size: 24),
              ),
              const SizedBox(width: 12),
              const Text('Collect Payment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Text(
                'Please collect the payment from the customer before marking the job as complete.',
                style: TextStyle(color: Colors.grey.shade600, height: 1.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.green.shade400, Colors.green.shade600]),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Text('Amount to Collect', style: TextStyle(color: Colors.white70, fontSize: 13)),
                    const SizedBox(height: 8),
                    Text(
                      '₹${amount.toStringAsFixed(0)}',
                      style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text('Cash on Delivery', style: TextStyle(color: Colors.white60, fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.amber.shade700, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Do not close the job without collecting payment.',
                        style: TextStyle(color: Colors.amber.shade800, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  Navigator.pop(context);
                  await ref.read(jobStatusProvider.notifier).collectCash(job.id, job.amount);
                  if (context.mounted) {
                    _showPhotoCaptureSheet(context, ref, job);
                  }
                },
                icon: const Icon(Icons.check_circle, color: Colors.white),
                label: const Text(
                  'Cash Collected ✓',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Not Yet — Go Back', style: TextStyle(color: Colors.grey)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPhotoCaptureSheet(BuildContext context, WidgetRef ref, BookingModel job) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          left: 24,
          right: 24,
          top: 24,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Complete Job',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Please capture the completed work photo and enter any additional charges if applicable.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                // In a real app, this would open the camera
                Navigator.pop(context);
                ref.read(jobStatusProvider.notifier).updateStatus(job.id, JobStatus.completed);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Job completed successfully!")),
                );
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text('Capture & Complete'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCallDialog(BuildContext context, String name, String phone) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Call $name?'),
        content: Text('Phone: ${phone.length > 4 ? phone.substring(0, 2) + "XXXXXX" + phone.substring(phone.length - 2) : phone}'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
            onPressed: () {
              Navigator.pop(context);
              _launchPhone(phone);
            },
            child: const Text('Call'),
          ),
        ],
      ),
    );
  }

  void _launchPhone(String phone) async {
    final url = Uri.parse('tel:$phone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}

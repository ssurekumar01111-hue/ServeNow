import 'package:flutter/material.dart';
import 'package:admin_web/app/utils/app_colors.dart';

class StatusChipWidget extends StatelessWidget {
  final String status;

  const StatusChipWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color text;

    switch (status.toLowerCase()) {
      case 'completed':
      case 'approved':
        bg = AppColors.successLight;
        text = AppColors.success;
        break;
      case 'pending':
      case 'pending_profile':
      case 'pending_approval':
        bg = AppColors.warningLight;
        text = AppColors.warning;
        break;
      case 'cancelled':
      case 'rejected':
      case 'error':
        bg = AppColors.errorLight;
        text = AppColors.error;
        break;
      case 'confirmed':
        bg = AppColors.infoLight;
        text = AppColors.info;
        break;
      case 'assigned':
        bg = AppColors.statPurple1.withOpacity(0.1);
        text = AppColors.statPurple1;
        break;
      case 'en_route':
      case 'en route':
        bg = Colors.cyan.withOpacity(0.1);
        text = Colors.cyan;
        break;
      case 'in_progress':
      case 'in progress':
        bg = AppColors.primaryLight;
        text = AppColors.primary;
        break;
      default:
        bg = AppColors.border;
        text = AppColors.textSecondary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.toUpperCase().replaceAll('_', ' '),
        style: TextStyle(
          color: text,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

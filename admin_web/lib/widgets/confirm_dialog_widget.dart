import 'package:flutter/material.dart';
import 'package:admin_web/app/utils/app_colors.dart';

class ConfirmDialogWidget extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final Color confirmColor;
  final VoidCallback onConfirm;
  final Widget? extraContent;

  const ConfirmDialogWidget({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.confirmColor = AppColors.primary,
    this.extraContent,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message),
          if (extraContent != null) ...[
            const SizedBox(height: 16),
            extraContent!,
          ]
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(cancelText, style: const TextStyle(color: AppColors.textSecondary)),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          style: ElevatedButton.styleFrom(backgroundColor: confirmColor, foregroundColor: Colors.white),
          child: Text(confirmText),
        ),
      ],
    );
  }
}

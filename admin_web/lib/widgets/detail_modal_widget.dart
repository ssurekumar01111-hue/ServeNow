import 'package:flutter/material.dart';
import 'package:admin_web/app/utils/app_colors.dart';
import 'package:admin_web/widgets/responsive_widget.dart';

class DetailModalWidget extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget>? actions;

  const DetailModalWidget({
    super.key,
    required this.title,
    required this.child,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final double width = ResponsiveWidget.isMobile(context) ? double.infinity : 480.0;

    return Drawer(
      width: width,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: child,
            ),
          ),
          if (actions != null && actions!.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions!,
              ),
            ),
        ],
      ),
    );
  }
}

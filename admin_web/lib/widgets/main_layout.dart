import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_web/app/utils/app_colors.dart';
import 'package:admin_web/widgets/responsive_widget.dart';
import 'package:admin_web/widgets/menu_widget.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final String title;

  const MainLayout({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ResponsiveWidget.isMobile(context)
          ? const Drawer(child: MenuWidget())
          : null,
      appBar: ResponsiveWidget.isMobile(context)
          ? AppBar(
              title: Text(title),
              actions: [
                _buildNotificationBell(),
                const SizedBox(width: 8),
              ],
            )
          : null,
      body: Row(
        children: [
          if (ResponsiveWidget.isDesktop(context))
            const SizedBox(
              width: 260,
              child: MenuWidget(),
            ),
          Expanded(
            child: Column(
              children: [
                if (ResponsiveWidget.isDesktop(context))
                  Container(
                    height: 70,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(color: AppColors.border),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const Spacer(),
                        _buildNotificationBell(),
                        const SizedBox(width: 16),
                        _buildAdminProfile(),
                      ],
                    ),
                  ),
                Expanded(
                  child: Container(
                    color: AppColors.background,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: child,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationBell() {
    return Stack(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_outlined,
              color: AppColors.textSecondary),
        ),
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: AppColors.error,
              shape: BoxShape.circle,
            ),
            child: const Text(
              '3',
              style: TextStyle(color: Colors.white, fontSize: 8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAdminProfile() {
    return Row(
      children: [
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Admin User',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              'Super Admin',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        CircleAvatar(
          backgroundColor: AppColors.primaryLight,
          child: const Text(
            'A',
            style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

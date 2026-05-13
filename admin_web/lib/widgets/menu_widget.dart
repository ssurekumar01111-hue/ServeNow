import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin_web/app/routes/app_pages.dart';
import 'package:admin_web/app/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.sidebarBg, AppColors.sidebarBg2],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMenuItem(
                    icon: Icons.dashboard_outlined,
                    label: 'Dashboard',
                    route: Routes.DASHBOARD,
                  ),
                  _buildSectionLabel('BOOKINGS'),
                  _buildMenuItem(
                    icon: Icons.calendar_today_outlined,
                    label: 'All Bookings',
                    route: Routes.BOOKINGS,
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('providers')
                        .where('onboardingStatus', isEqualTo: 'pending_approval')
                        .snapshots(),
                    builder: (context, snapshot) {
                      final count = snapshot.hasData ? snapshot.data!.docs.length : 0;
                      return _buildMenuItem(
                        icon: Icons.verified_user_outlined,
                        label: 'Provider Approvals',
                        route: Routes.PROVIDER_APPROVALS,
                        badge: count > 0 ? count.toString() : null,
                      );
                    },
                  ),
                  _buildSectionLabel('USERS'),
                  _buildMenuItem(
                    icon: Icons.people_outline,
                    label: 'Customers',
                    route: Routes.CUSTOMERS,
                  ),
                  _buildMenuItem(
                    icon: Icons.engineering_outlined,
                    label: 'Providers',
                    route: Routes.PROVIDERS,
                  ),
                  _buildMenuItem(
                    icon: Icons.handyman_outlined,
                    label: 'Handymen',
                    route: Routes.HANDYMEN,
                  ),
                  _buildSectionLabel('SERVICES'),
                  _buildMenuItem(
                    icon: Icons.category_outlined,
                    label: 'Categories',
                    route: Routes.CATEGORIES,
                  ),
                  _buildMenuItem(
                    icon: Icons.design_services_outlined,
                    label: 'Services & Pricing',
                    route: Routes.SERVICES,
                  ),
                  _buildSectionLabel('FINANCE'),
                  _buildMenuItem(
                    icon: Icons.account_balance_wallet_outlined,
                    label: 'Withdrawals',
                    route: Routes.WITHDRAWALS,
                  ),
                  _buildMenuItem(
                    icon: Icons.analytics_outlined,
                    label: 'Analytics',
                    route: Routes.ANALYTICS,
                  ),
                  _buildMenuItem(
                    icon: Icons.confirmation_number_outlined,
                    label: 'Coupons',
                    route: Routes.COUPONS,
                  ),
                  _buildSectionLabel('COMMUNICATIONS'),
                  _buildMenuItem(
                    icon: Icons.campaign_outlined,
                    label: 'Announcements',
                    route: Routes.ANNOUNCEMENTS,
                  ),
                  _buildMenuItem(
                    icon: Icons.chat_outlined,
                    label: 'Support Chats',
                    route: Routes.SUPPORT_CHATS,
                  ),
                  _buildSectionLabel('SETTINGS'),
                  _buildMenuItem(
                    icon: Icons.settings_outlined,
                    label: 'Platform Settings',
                    route: Routes.SETTINGS,
                  ),
                  _buildMenuItem(
                    icon: Icons.admin_panel_settings_outlined,
                    label: 'Admin Users',
                    route: Routes.ADMIN_USERS,
                  ),
                ],
              ),
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.home_repair_service, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ServeNow',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Admin Panel',
                style: TextStyle(
                  color: AppColors.sidebarText.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.sidebarText,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required String route,
    String? badge,
  }) {
    final bool isActive = Get.currentRoute == route;

    return InkWell(
      onTap: () => Get.offNamed(route),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          border: isActive
              ? const Border(
                  left: BorderSide(color: AppColors.primary, width: 3),
                )
              : null,
          color: isActive ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isActive ? Colors.white : AppColors.sidebarText,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: isActive ? Colors.white : AppColors.sidebarText,
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (badge != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white10),
        ),
      ),
      child: InkWell(
        onTap: () async {
          await FirebaseAuth.instance.signOut();
          Get.offAllNamed(Routes.LOGIN);
        },
        child: Row(
          children: [
            const Icon(Icons.logout, color: AppColors.error, size: 20),
            const SizedBox(width: 16),
            const Text(
              'Logout',
              style: TextStyle(
                color: AppColors.sidebarText,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:get/get.dart';
import 'package:admin_web/app/modules/splash/bindings/splash_binding.dart';
import 'package:admin_web/app/modules/splash/views/splash_view.dart';
import 'package:admin_web/app/modules/login/bindings/login_binding.dart';
import 'package:admin_web/app/modules/login/views/login_view.dart';
import 'package:admin_web/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:admin_web/app/modules/dashboard/views/dashboard_view.dart';
import 'package:admin_web/app/modules/bookings/bindings/bookings_binding.dart';
import 'package:admin_web/app/modules/bookings/views/bookings_view.dart';
import 'package:admin_web/app/modules/customers/bindings/customers_binding.dart';
import 'package:admin_web/app/modules/customers/views/customers_view.dart';
import 'package:admin_web/app/modules/providers/bindings/providers_binding.dart';
import 'package:admin_web/app/modules/providers/views/providers_view.dart';
import 'package:admin_web/app/modules/providers/bindings/provider_approvals_binding.dart';
import 'package:admin_web/app/modules/providers/views/provider_approvals_view.dart';
import 'package:admin_web/app/modules/handymen/bindings/handymen_binding.dart';
import 'package:admin_web/app/modules/handymen/views/handymen_view.dart';
import 'package:admin_web/app/modules/categories/bindings/categories_binding.dart';
import 'package:admin_web/app/modules/categories/views/categories_view.dart';
import 'package:admin_web/app/modules/services/bindings/services_binding.dart';
import 'package:admin_web/app/modules/services/views/services_view.dart';
import 'package:admin_web/app/modules/coupons/bindings/coupons_binding.dart';
import 'package:admin_web/app/modules/coupons/views/coupons_view.dart';
import 'package:admin_web/app/modules/ratings/bindings/ratings_binding.dart';
import 'package:admin_web/app/modules/ratings/views/ratings_view.dart';
import 'package:admin_web/app/modules/withdrawals/bindings/withdrawals_binding.dart';
import 'package:admin_web/app/modules/withdrawals/views/withdrawals_view.dart';
import 'package:admin_web/app/modules/analytics/bindings/analytics_binding.dart';
import 'package:admin_web/app/modules/analytics/views/analytics_view.dart';
import 'package:admin_web/app/modules/announcements/bindings/announcements_binding.dart';
import 'package:admin_web/app/modules/announcements/views/announcements_view.dart';
import 'package:admin_web/app/modules/settings/bindings/settings_binding.dart';
import 'package:admin_web/app/modules/settings/views/settings_view.dart';
import 'package:admin_web/app/modules/support/bindings/support_binding.dart';
import 'package:admin_web/app/modules/support/views/support_view.dart';
import 'package:admin_web/app/modules/admins/bindings/admins_binding.dart';
import 'package:admin_web/app/modules/admins/views/admins_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.BOOKINGS,
      page: () => const BookingsView(),
      binding: BookingsBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMERS,
      page: () => const CustomersView(),
      binding: CustomersBinding(),
    ),
    GetPage(
      name: _Paths.PROVIDERS,
      page: () => const ProvidersView(),
      binding: ProvidersBinding(),
    ),
    GetPage(
      name: _Paths.PROVIDER_APPROVALS,
      page: () => const ProviderApprovalsView(),
      binding: ProviderApprovalsBinding(),
    ),
    GetPage(
      name: _Paths.HANDYMEN,
      page: () => const HandymenView(),
      binding: HandymenBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORIES,
      page: () => const CategoriesView(),
      binding: CategoriesBinding(),
    ),
    GetPage(
      name: _Paths.SERVICES,
      page: () => const ServicesView(),
      binding: ServicesBinding(),
    ),
    GetPage(
      name: _Paths.COUPONS,
      page: () => const CouponsView(),
      binding: CouponsBinding(),
    ),
    GetPage(
      name: _Paths.RATINGS,
      page: () => const RatingsView(),
      binding: RatingsBinding(),
    ),
    GetPage(
      name: _Paths.WITHDRAWALS,
      page: () => const WithdrawalsView(),
      binding: WithdrawalsBinding(),
    ),
    GetPage(
      name: _Paths.ANALYTICS,
      page: () => const AnalyticsView(),
      binding: AnalyticsBinding(),
    ),
    GetPage(
      name: _Paths.ANNOUNCEMENTS,
      page: () => const AnnouncementsView(),
      binding: AnnouncementsBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.SUPPORT_CHATS,
      page: () => const SupportView(),
      binding: SupportBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_USERS,
      page: () => const AdminsView(),
      binding: AdminsBinding(),
    ),
  ];
}

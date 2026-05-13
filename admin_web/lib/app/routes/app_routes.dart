part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const LOGIN = _Paths.LOGIN;
  static const DASHBOARD = _Paths.DASHBOARD;
  static const BOOKINGS = _Paths.BOOKINGS;
  static const BOOKING_DETAIL = _Paths.BOOKING_DETAIL;
  static const CUSTOMERS = _Paths.CUSTOMERS;
  static const CUSTOMER_DETAIL = _Paths.CUSTOMER_DETAIL;
  static const PROVIDERS = _Paths.PROVIDERS;
  static const PROVIDER_DETAIL = _Paths.PROVIDER_DETAIL;
  static const PROVIDER_APPROVALS = _Paths.PROVIDER_APPROVALS;
  static const HANDYMEN = _Paths.HANDYMEN;
  static const HANDYMAN_DETAIL = _Paths.HANDYMAN_DETAIL;
  static const SERVICES = _Paths.SERVICES;
  static const CATEGORIES = _Paths.CATEGORIES;
  static const COUPONS = _Paths.COUPONS;
  static const RATINGS = _Paths.RATINGS;
  static const WITHDRAWALS = _Paths.WITHDRAWALS;
  static const ANALYTICS = _Paths.ANALYTICS;
  static const ANNOUNCEMENTS = _Paths.ANNOUNCEMENTS;
  static const SETTINGS = _Paths.SETTINGS;
  static const SUPPORT_CHATS = _Paths.SUPPORT_CHATS;
  static const ADMIN_USERS = _Paths.ADMIN_USERS;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const LOGIN = '/login';
  static const DASHBOARD = '/dashboard';
  static const BOOKINGS = '/bookings';
  static const BOOKING_DETAIL = '/booking-detail';
  static const CUSTOMERS = '/customers';
  static const CUSTOMER_DETAIL = '/customer-detail';
  static const PROVIDERS = '/providers';
  static const PROVIDER_DETAIL = '/provider-detail';
  static const PROVIDER_APPROVALS = '/provider-approvals';
  static const HANDYMEN = '/handymen';
  static const HANDYMAN_DETAIL = '/handyman-detail';
  static const SERVICES = '/services';
  static const CATEGORIES = '/categories';
  static const COUPONS = '/coupons';
  static const RATINGS = '/ratings';
  static const WITHDRAWALS = '/withdrawals';
  static const ANALYTICS = '/analytics';
  static const ANNOUNCEMENTS = '/announcements';
  static const SETTINGS = '/settings';
  static const SUPPORT_CHATS = '/support-chats';
  static const ADMIN_USERS = '/admin-users';
}

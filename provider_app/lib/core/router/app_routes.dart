class AppRoutes {
  // Auth
  static const String splash = '/';
  static const String login = '/login';
  static const String otpVerify = '/otp-verify';
  static const String registration = '/registration';
  static const String verificationPending = '/verification-pending';

  // Dashboard & Main
  static const String dashboard = '/dashboard';
  static const String notifications = '/notifications';
  static const String profile = '/profile';
  static const String settings = '/settings';

  // Bookings
  static const String bookings = '/bookings';
  static const String bookingDetail = '/bookings/:bookingId';

  // Services
  static const String services = '/services';
  static const String addService = '/services/add';
  static const String editService = '/services/edit/:serviceId';

  // Handymen
  static const String handymen = '/handymen';
  static const String addHandyman = '/handymen/add';

  // Earnings & Wallet
  static const String earnings = '/earnings';
  static const String wallet = '/wallet';
  static const String withdrawal = '/wallet/withdraw';

  // Communication
  static const String chat = '/chat/:bookingId';

  // Helper for parameterized routes
  static String bookingDetailPath(String bookingId) => '/bookings/$bookingId';
  static String editServicePath(String serviceId) => '/services/edit/$serviceId';
  static String chatPath(String bookingId) => '/chat/$bookingId';
}

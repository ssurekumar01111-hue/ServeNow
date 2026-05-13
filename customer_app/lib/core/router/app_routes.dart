class AppRoutes {
  // Auth
  static const splash = '/splash';
  static const welcome = '/welcome';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const otp = '/otp-verify';
  static const blocked = '/blocked';

  // Main
  static const home = '/home';
  static const notifications = '/notifications';
  static const profile = '/profile';
  static const settings = '/settings';
  static const allCategories = '/categories';
  static const allProviders = '/providers';
  static const allServices = '/services';

  // Services
  static const categoryServices = '/category/:categoryId';
  static const serviceDetail = '/service/:serviceId';
  static const providerProfile = '/provider/:providerId';

  // Booking
  static const bookingForm = '/booking/form';
  static const coupon = '/booking/coupon';
  static const checkout = '/booking/checkout';
  static const bookingConfirmation = '/booking/confirmation';
  static const myBookings = '/bookings';
  static const bookingDetail = '/booking/:bookingId';
  static const liveTracking = '/tracking/:bookingId';

  // Wallet & Reviews
  static const wallet = '/wallet';
  static const review = '/review/:bookingId';

  // Profile extras
  static const savedAddresses = '/addresses';
  static const addAddress = '/add-address';
  static const referral = '/referral';
  static const support = '/support';
  static const rateReview = '/rate-review/:bookingId/:providerId';
  static const chat = '/chat/:bookingId';

  // Helper for parameterized routes
  static String categoryServicesPath(String categoryId) => '/category/$categoryId';
  static String serviceDetailPath(String serviceId) => '/service/$serviceId';
  static String providerProfilePath(String providerId) => '/provider/$providerId';
  static String bookingDetailPath(String bookingId) => '/booking/$bookingId';
  static String liveTrackingPath(String bookingId) => '/tracking/$bookingId';
  static String reviewPath(String bookingId) => '/review/$bookingId';
  static String rateReviewPath(String bookingId, String providerId) => '/rate-review/$bookingId/$providerId';
  static String chatPath(String bookingId) => '/chat/$bookingId';
}

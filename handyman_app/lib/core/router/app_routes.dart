class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String onboarding = '/onboarding';
  static const String pendingApproval = '/pending-approval';
  static const String rejected = '/rejected';
  static const String otpVerify = '/otp-verify';
  static const String dashboard = '/dashboard';
  static const String jobs = '/jobs';
  static const String jobDetail = '/jobs/:id';
  static const String otpVerifyJob = '/jobs/:id/verify';
  static const String earnings = '/earnings';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String notifications = '/notifications';
  static const String chat = '/chat/:id';

  // Protected routes list
  static const List<String> protectedRoutes = [
    signUp,
    onboarding,
    pendingApproval,
    rejected,
    dashboard,
    jobs,
    jobDetail,
    otpVerifyJob,
    earnings,
    profile,
    settings,
    notifications,
    chat,
  ];

  // Helper for dynamic routes
  static String jobDetailPath(String id) => '/jobs/$id';
  static String otpVerifyJobPath(String id) => '/jobs/$id/verify';
  static String chatPath(String id) => '/chat/$id';
}

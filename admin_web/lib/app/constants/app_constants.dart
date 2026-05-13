import 'package:admin_web/app/models/admin_model.dart';

class AppConstants {
  static AdminModel? adminModel;
  static String appName = 'ServeNow Admin';
  static String currencySymbol = '₹';
  static double defaultCommission = 10.0;
  static const String themeKey = "isDarkMode";

  static String formatAmount(double amount) {
    return '$currencySymbol${amount.toStringAsFixed(2)}';
  }

  static String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

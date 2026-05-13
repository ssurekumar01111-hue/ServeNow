import 'package:flutter/material.dart';

class AppColors {
  // Primary Brand Colors — Deep Blue to Purple gradient feel
  static const Color primary = Color(0xFF4A6CF7);        // Vibrant blue
  static const Color primaryDark = Color(0xFF3451D1);    // Darker blue
  static const Color primaryLight = Color(0xFF7B95FF);   // Light blue
  static const Color secondary = Color(0xFF7C3AED);      // Purple accent

  // Gradient definitions
  static const List<Color> primaryGradient = [Color(0xFF4A6CF7), Color(0xFF7C3AED)];
  static const List<Color> splashGradient = [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)];
  static const List<Color> cardGradient = [Color(0xFF4A6CF7), Color(0xFF7C3AED)];

  // Background Colors
  static const Color background = Color(0xFFF8F9FF);     // Very light blue-white
  static const Color backgroundDark = Color(0xFF0F0F23); // Dark navy for dark mode
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1A1A2E);

  // Card Colors
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF16213E);

  // Text Colors
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFF9CA3AF);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Booking Status Colors
  static const Color statusPending = Color(0xFFF59E0B);
  static const Color statusConfirmed = Color(0xFF3B82F6);
  static const Color statusInProgress = Color(0xFF8B5CF6);
  static const Color statusCompleted = Color(0xFF10B981);
  static const Color statusCancelled = Color(0xFFEF4444);

  // Category Colors
  static const Color cleaningColor = Color(0xFF4A6CF7);
  static const Color acRepairColor = Color(0xFF10B981);
  static const Color plumbingColor = Color(0xFF3B82F6);
  static const Color electricalColor = Color(0xFFF59E0B);
  static const Color beautyColor = Color(0xFFEC4899);
  static const Color defaultCategoryColor = Color(0xFF8B5CF6);

  // Shadow
  static const Color shadow = Color(0x1A4A6CF7);
  static const Color shadowDark = Color(0x40000000);
}

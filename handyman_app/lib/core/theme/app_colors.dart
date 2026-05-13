import 'package:flutter/material.dart';

class AppColors {
  // Primary Brand Colors — Green theme for Handyman (Pro) app
  static const Color primary = Color(0xFF2E7D32);        // Green 800
  static const Color primaryDark = Color(0xFF1B5E20);    // Green 900
  static const Color primaryLight = Color(0xFF4CAF50);   // Green 500
  static const Color secondary = Color(0xFF00897B);      // Teal 600

  // Gradient definitions
  static const List<Color> primaryGradient = [Color(0xFF1B5E20), Color(0xFF2E7D32), Color(0xFF388E3C)];
  static const List<Color> splashGradient = [Color(0xFF0A2E0C), Color(0xFF1B5E20), Color(0xFF2E7D32)];
  static const List<Color> cardGradient = [Color(0xFF2E7D32), Color(0xFF388E3C)];

  // Background Colors
  static const Color background = Color(0xFFF1F8E9);     // Very light green background
  static const Color backgroundDark = Color(0xFF0A1F0B); // Dark green for dark mode
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1B2E1C);

  // Card Colors
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF2E3E2F);

  // Text Colors
  static const Color textPrimary = Color(0xFF1B2E1C);
  static const Color textSecondary = Color(0xFF455A64);
  static const Color textHint = Color(0xFF90A4AE);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Booking Status Colors
  static const Color statusPending = Color(0xFFF59E0B);
  static const Color statusConfirmed = Color(0xFF3B82F6);
  static const Color statusInProgress = Color(0xFF00897B); // Secondary color for in progress
  static const Color statusCompleted = Color(0xFF2E7D32); // Primary color for completed
  static const Color statusCancelled = Color(0xFFEF4444);

  // Category Colors
  static const Color cleaningColor = Color(0xFF4CAF50);
  static const Color acRepairColor = Color(0xFF10B981);
  static const Color plumbingColor = Color(0xFF3B82F6);
  static const Color electricalColor = Color(0xFFF59E0B);
  static const Color beautyColor = Color(0xFFEC4899);
  static const Color defaultCategoryColor = Color(0xFF2E7D32);

  // Shadow
  static const Color shadow = Color(0x1A2E7D32);
  static const Color shadowDark = Color(0x40000000);
}

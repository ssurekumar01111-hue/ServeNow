import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget desktop;
  final Widget? tablet;
  final Widget mobile;

  const ResponsiveWidget({
    super.key,
    required this.desktop,
    this.tablet,
    required this.mobile,
  });

  static bool isMobile(BuildContext context) {
    try {
      return MediaQuery.of(context).size.width <= 600;
    } catch (e) {
      return false;
    }
  }

  static bool isTablet(BuildContext context) {
    try {
      final width = MediaQuery.of(context).size.width;
      return width > 600 && width < 1100;
    } catch (e) {
      return false;
    }
  }

  static bool isDesktop(BuildContext context) {
    try {
      return MediaQuery.of(context).size.width >= 1100;
    } catch (e) {
      return true; // Default to desktop if media query fails (safer for admin panel)
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100) {
          return desktop;
        } else if (constraints.maxWidth > 600) {
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}

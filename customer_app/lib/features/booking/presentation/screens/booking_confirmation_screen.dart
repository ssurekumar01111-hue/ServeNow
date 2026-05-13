import 'package:customer/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookingConfirmationScreen extends StatefulWidget {
  const BookingConfirmationScreen({super.key});

  @override
  State<BookingConfirmationScreen> createState() => _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
  bool _isAnimated = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) setState(() => _isAnimated = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedScale(
              scale: _isAnimated ? 1.0 : 0.0,
              duration: const Duration(seconds: 1),
              curve: Curves.elasticOut,
              child: const Icon(Icons.check_circle, color: Colors.green, size: 100),
            ),
            const SizedBox(height: 24),
            const Text('Booking Confirmed!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text('Your service has been scheduled successfully.'),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.myBookings),
              child: const Text('View My Bookings'),
            ),
            TextButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

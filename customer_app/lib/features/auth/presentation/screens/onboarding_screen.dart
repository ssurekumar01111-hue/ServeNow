import 'package:customer/core/router/app_routes.dart';
import 'package:customer/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingData {
  final List<Color> gradient;
  final IconData icon;
  final String title;
  final String subtitle;

  OnboardingData({
    required this.gradient,
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> slides = [
    OnboardingData(
      gradient: [const Color(0xFF4A6CF7), const Color(0xFF7C3AED)],
      icon: Icons.home_repair_service_rounded,
      title: 'Professional Home\nServices',
      subtitle: 'Book trusted professionals for all your home service needs in just a few taps.',
    ),
    OnboardingData(
      gradient: [const Color(0xFF11998E), const Color(0xFF38EF7D)],
      icon: Icons.calendar_today_rounded,
      title: 'Book at Your\nConvenience',
      subtitle: 'Choose your preferred time slot and get service at your doorstep.',
    ),
    OnboardingData(
      gradient: [const Color(0xFFFC4A1A), const Color(0xFFF7B733)],
      icon: Icons.verified_rounded,
      title: 'Trusted & Verified\nProfessionals',
      subtitle: 'All our service providers are background verified and professionally trained.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: slides.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final slide = slides[index];
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: slide.gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withValues(alpha: 0.1),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            slide.icon,
                            size: 64,
                            color: slide.gradient[0],
                          ),
                        ),
                      ),
                      const SizedBox(height: 64),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          slide.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            height: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          slide.subtitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 48,
            right: 24,
            child: TextButton(
              onPressed: () => context.go(AppRoutes.login),
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 48,
            left: 24,
            right: 24,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    slides.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(right: 8),
                      height: 8,
                      width: _currentPage == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? Colors.white : Colors.white.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage < slides.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        context.go(AppRoutes.login);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: slides[_currentPage].gradient[0],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      _currentPage == slides.length - 1 ? 'Get Started' : 'Next',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

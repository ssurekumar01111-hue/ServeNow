import 'dart:async';
import 'package:customer/features/home/presentation/providers/home_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BannerCarousel extends ConsumerStatefulWidget {
  const BannerCarousel({super.key});

  @override
  ConsumerState<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends ConsumerState<BannerCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<List<Color>> _gradients = [
    [const Color(0xFF6448FE), const Color(0xFF5FC6FF)],
    [const Color(0xFF11998E), const Color(0xFF38EF7D)],
    [const Color(0xFFFC4A1A), const Color(0xFFF7B733)],
    [const Color(0xFF834D9B), const Color(0xFFD04ED6)],
  ];

  @override
  void initState() {
    super.initState();
  }

  void _startAutoScroll(int itemCount) {
    _timer?.cancel();
    if (itemCount <= 1) return;
    
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < itemCount - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bannersAsync = ref.watch(bannersProvider);

    return bannersAsync.when(
      data: (banners) {
        if (banners.isEmpty) return const SizedBox.shrink();
        
        // Start auto scroll once data is available
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_timer == null) _startAutoScroll(banners.length);
        });

        return Column(
          children: [
            SizedBox(
              height: 160,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: banners.length,
                itemBuilder: (context, index) {
                  final banner = banners[index];
                  final gradient = _gradients[index % _gradients.length];
                  
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: gradient,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      image: banner.imageUrl.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(banner.imageUrl),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.2),
                                BlendMode.darken,
                              ),
                            )
                          : null,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  banner.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  banner.subtitle,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 13,
                                  ),
                                ),
                                if (banner.actionType != 'none') ...[
                                  const SizedBox(height: 12),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      'Book Now',
                                      style: TextStyle(
                                        color: gradient[0],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            // Dot indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(banners.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: _currentPage == index ? 20 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              }),
            ),
          ],
        );
      },
      loading: () => const SizedBox(
        height: 160,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, st) => const SizedBox.shrink(),
    );
  }
}

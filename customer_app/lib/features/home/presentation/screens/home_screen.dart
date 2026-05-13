import 'package:customer/core/router/app_routes.dart';
import 'package:customer/core/theme/app_colors.dart';
import 'package:customer/features/home/domain/entities/category_entity.dart';
import 'package:customer/features/home/domain/entities/provider_summary_entity.dart';
import 'package:customer/features/home/presentation/providers/home_providers.dart';
import 'package:customer/features/home/presentation/providers/location_provider.dart';
import 'package:customer/features/home/presentation/widgets/banner_carousel.dart';
import 'package:customer/features/services/domain/entities/service_entity.dart';
import 'package:customer/features/services/presentation/providers/services_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  IconData getCategoryIcon(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'cleaning': return Icons.cleaning_services_rounded;
      case 'ac repair': return Icons.ac_unit_rounded;
      case 'plumbing': return Icons.plumbing_rounded;
      case 'electrical': return Icons.electrical_services_rounded;
      case 'beauty & salon': return Icons.face_retouching_natural_rounded;
      default: return Icons.home_repair_service_rounded;
    }
  }

  Color getCategoryColor(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'cleaning': return AppColors.cleaningColor;
      case 'ac repair': return AppColors.acRepairColor;
      case 'plumbing': return AppColors.plumbingColor;
      case 'electrical': return AppColors.electricalColor;
      case 'beauty & salon': return AppColors.beautyColor;
      default: return AppColors.defaultCategoryColor;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final nearbyProviders = ref.watch(nearbyProvidersProvider);
    final popularServices = ref.watch(popularServicesProvider);
    final locationState = ref.watch(locationProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 180)), // Space for custom AppBar
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const BannerCarousel(),
                    const SizedBox(height: 24),
                    _buildSectionHeader(context, 'Categories', AppRoutes.allCategories),
                    _buildCategories(context, categories),
                    const SizedBox(height: 24),
                    _buildSectionHeader(context, 'Special Offers', ''),
                    _buildSpecialOffers(context),
                    const SizedBox(height: 24),
                    _buildSectionHeader(context, 'Nearby Providers', AppRoutes.allProviders),
                    _buildNearbyProviders(context, nearbyProviders),
                    const SizedBox(height: 24),
                    _buildHowItWorks(context),
                    const SizedBox(height: 24),
                    _buildPopularServices(context, popularServices),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
          _buildCustomAppBar(context, ref, locationState),
        ],
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context, WidgetRef ref, AsyncValue<LocationData> locationState) {
    final cityName = locationState.when(
      data: (loc) => loc.cityName,
      loading: () => 'Detecting...',
      error: (_, __) => 'Enable Location',
    );

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Location + notification row
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.white70, size: 18),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Your Location', style: TextStyle(color: Colors.white60, fontSize: 11, fontFamily: 'Poppins')),
                        GestureDetector(
                          onTap: () => ref.read(locationProvider.notifier).refreshLocation(),
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  cityName,
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Poppins'),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                    onPressed: () => context.push(AppRoutes.notifications),
                  ),
                  IconButton(
                    icon: const Icon(Icons.account_balance_wallet_outlined, color: Colors.white),
                    onPressed: () => context.push(AppRoutes.wallet),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Search bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (value) => ref.read(searchQueryProvider.notifier).state = value,
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      context.push(AppRoutes.allServices, extra: value);
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Search for services...',
                    hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 14),
                    prefixIcon: const Icon(Icons.search_rounded, color: AppColors.primary),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary, fontFamily: 'Poppins'),
          ),
          if (route.isNotEmpty)
            TextButton(
              onPressed: () => context.push(route),
              child: const Text('See All', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
            ),
        ],
      ),
    );
  }

  Widget _buildCategories(BuildContext context, AsyncValue<List<CategoryEntity>> categories) {
    return categories.when(
      data: (items) {
        if (items.isEmpty) return const SizedBox.shrink();
        final previewItems = items.take(4).toList();
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.75,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: previewItems.length,
          itemBuilder: (context, index) {
            final cat = previewItems[index];
            return _buildCategoryCard(context, cat);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => const SizedBox.shrink(),
    );
  }

  Widget _buildCategoryCard(BuildContext context, CategoryEntity category) {
    final color = getCategoryColor(category.name);
    final icon = getCategoryIcon(category.name);
    return GestureDetector(
      onTap: () => context.push(AppRoutes.categoryServicesPath(category.id), extra: category.name),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.12),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: category.iconUrl.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        category.iconUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(icon, color: Colors.white, size: 24),
                      ),
                    )
                  : Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                category.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  fontFamily: 'Poppins',
                  height: 1.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialOffers(BuildContext context) {
    final offers = [
      {'title': 'AC Service', 'discount': '30% OFF', 'price': '₹299', 'color': AppColors.acRepairColor},
      {'title': 'Deep Cleaning', 'discount': '20% OFF', 'price': '₹499', 'color': AppColors.cleaningColor},
      {'title': 'Electrician', 'discount': '15% OFF', 'price': '₹199', 'color': AppColors.electricalColor},
      {'title': 'Plumber', 'discount': '25% OFF', 'price': '₹249', 'color': AppColors.plumbingColor},
    ];

    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: offers.length,
        itemBuilder: (context, index) {
          final offer = offers[index];
          final color = offer['color'] as Color;
          return Container(
            width: 160,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.8), color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: color.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4)),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    offer['discount'] as String,
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offer['title'] as String,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15, fontFamily: 'Poppins'),
                    ),
                    Text(
                      'Starting ${offer['price']}',
                      style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNearbyProviders(BuildContext context, AsyncValue<List<ProviderSummaryEntity>> nearbyProviders) {
    return nearbyProviders.when(
      data: (items) => SizedBox(
        height: 220,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final provider = items[index];
            return _buildProviderCard(context, provider);
          },
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => const SizedBox.shrink(),
    );
  }

  Widget _buildProviderCard(BuildContext context, ProviderSummaryEntity provider) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.providerProfilePath(provider.id)),
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16, bottom: 8, top: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        provider.businessName.substring(0, 1).toUpperCase(),
                        style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (provider.isVerified)
                    const Icon(Icons.verified_rounded, color: AppColors.primary, size: 20),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                provider.businessName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary, fontFamily: 'Poppins'),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.star_rounded, color: AppColors.warning, size: 16),
                  const SizedBox(width: 4),
                  Text(provider.rating.toString(), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  Text(' (${provider.reviewCount})', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 14, color: AppColors.textSecondary),
                  const SizedBox(width: 2),
                  Text('${provider.distance?.toStringAsFixed(1) ?? "0.0"} km', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text('View Profile', style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHowItWorks(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('How It Works', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary, fontFamily: 'Poppins')),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 10)),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStep(context, Icons.search_rounded, 'Select', AppColors.primary),
                _buildStepArrow(),
                _buildStep(context, Icons.calendar_today_rounded, 'Book', AppColors.acRepairColor),
                _buildStepArrow(),
                _buildStep(context, Icons.handyman_rounded, 'Service', AppColors.warning),
                _buildStepArrow(),
                _buildStep(context, Icons.thumb_up_rounded, 'Enjoy', AppColors.success),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(BuildContext context, IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
      ],
    );
  }

  Widget _buildStepArrow() {
    return Icon(Icons.arrow_forward_ios_rounded, size: 12, color: Colors.grey.shade300);
  }

  Widget _buildPopularServices(BuildContext context, AsyncValue<List<ServiceEntity>> services) {
    return services.when(
      data: (items) {
        final preview = items.take(4).toList();
        if (preview.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, 'Popular Services', AppRoutes.allServices),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: preview.map((service) => _buildPopularServiceCard(context, service)).toList(),
              ),
            ),
          ],
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.all(20),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Padding(
        padding: const EdgeInsets.all(16),
        child: Text('Error loading services: $e', style: const TextStyle(color: Colors.red, fontSize: 12)),
      ),
    );
  }

  Widget _buildPopularServiceCard(BuildContext context, ServiceEntity service) {
    final hasDiscount = service.discountPrice != null && service.discountPrice! < service.basePrice;
    final displayPrice = hasDiscount ? service.discountPrice! : service.basePrice;
    final categoryColor = getCategoryColor(service.categoryName ?? '');

    return GestureDetector(
      onTap: () => context.push(AppRoutes.serviceDetailPath(service.id)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: categoryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(getCategoryIcon(service.categoryName ?? ''), color: categoryColor, size: 36),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary, fontFamily: 'Poppins'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, color: AppColors.warning, size: 14),
                        const SizedBox(width: 2),
                        Text(service.rating.toStringAsFixed(1), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        const Icon(Icons.access_time_rounded, size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 2),
                        Text('${service.duration} min', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '₹${displayPrice.toInt()}',
                          style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        if (hasDiscount) ...[
                          const SizedBox(width: 8),
                          Text(
                            '₹${service.basePrice.toInt()}',
                            style: TextStyle(decoration: TextDecoration.lineThrough, color: AppColors.textHint, fontSize: 14),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add_rounded, color: AppColors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

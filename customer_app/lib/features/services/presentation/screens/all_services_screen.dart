import 'package:customer/core/router/app_routes.dart';
import 'package:customer/features/services/domain/entities/service_entity.dart';
import 'package:customer/features/services/presentation/providers/services_providers.dart';
import 'package:customer/features/home/presentation/providers/home_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AllServicesScreen extends ConsumerStatefulWidget {
  const AllServicesScreen({super.key});

  @override
  ConsumerState<AllServicesScreen> createState() => _AllServicesScreenState();
}

class _AllServicesScreenState extends ConsumerState<AllServicesScreen> {
  String _selectedCategory = 'All';

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
      case 'cleaning': return const Color(0xFF6448FE);
      case 'ac repair': return const Color(0xFF11998E);
      case 'plumbing': return const Color(0xFF2196F3);
      case 'electrical': return const Color(0xFFFF9800);
      case 'beauty & salon': return const Color(0xFFE91E63);
      default: return const Color(0xFF9C27B0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final allServicesAsync = ref.watch(allServicesProvider);
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Services'),
      ),
      body: Column(
        children: [
          categoriesAsync.when(
            data: (categories) {
              final allCategories = ['All', ...categories.map((c) => c.name)];
              return SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: allCategories.length,
                  itemBuilder: (context, index) {
                    final category = allCategories[index];
                    final isSelected = _selectedCategory == category;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() => _selectedCategory = category);
                        },
                        selectedColor: Theme.of(context).colorScheme.primaryContainer,
                        checkmarkColor: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  },
                ),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: allServicesAsync.when(
              data: (services) {
                final filteredServices = services.where((s) {
                  return _selectedCategory == 'All' || (s.categoryName ?? '').toLowerCase() == _selectedCategory.toLowerCase();
                }).toList();

                if (filteredServices.isEmpty) {
                  return const Center(child: Text('No services found in this category'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredServices.length,
                  itemBuilder: (context, index) {
                    final service = filteredServices[index];
                    return _buildPopularServiceCard(context, service);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text('Error: $error'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => ref.invalidate(allServicesProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: categoryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(getCategoryIcon(service.categoryName ?? ''), color: categoryColor, size: 32),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: categoryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              service.categoryName ?? '',
                              style: TextStyle(color: categoryColor, fontSize: 10, fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        if (hasDiscount) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              '${(((service.basePrice - displayPrice) / service.basePrice) * 100).round()}% OFF',
                              style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(service.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Text(service.providerName ?? '', style: TextStyle(fontSize: 11, color: Colors.grey.shade500), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, color: Colors.amber, size: 13),
                        Text(' ${service.rating.toStringAsFixed(1)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                        Text(' · ', style: TextStyle(color: Colors.grey.shade400)),
                        Icon(Icons.access_time_rounded, size: 12, color: Colors.grey.shade500),
                        Text(' ${service.duration} min', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (hasDiscount)
                    Text(
                      '₹${service.basePrice.toInt()}',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey.shade400,
                        fontSize: 11,
                      ),
                    ),
                  Text(
                    '₹${displayPrice.toInt()}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => context.push(AppRoutes.bookingForm, extra: service),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Book', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

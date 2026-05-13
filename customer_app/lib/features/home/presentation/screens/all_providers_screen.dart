import 'package:customer/core/router/app_routes.dart';
import 'package:customer/core/theme/app_colors.dart';
import 'package:customer/core/widgets/cached_image_widget.dart';
import 'package:customer/core/utils/demo_data.dart';
import 'package:customer/features/home/domain/entities/provider_summary_entity.dart';
import 'package:customer/features/home/presentation/providers/home_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AllProvidersScreen extends ConsumerStatefulWidget {
  const AllProvidersScreen({super.key});

  @override
  ConsumerState<AllProvidersScreen> createState() => _AllProvidersScreenState();
}

class _AllProvidersScreenState extends ConsumerState<AllProvidersScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final providersAsync = ref.watch(nearbyProvidersProvider);
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Providers'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search providers...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
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
          const SizedBox(height: 16),
          Expanded(
            child: providersAsync.when(
              data: (providers) {
                final filteredProviders = providers.where((p) {
                  final matchesSearch = p.businessName.toLowerCase().contains(_searchQuery.toLowerCase());
                  final matchesCategory = _selectedCategory == 'All' || p.categories.contains(_selectedCategory);
                  return matchesSearch && matchesCategory;
                }).toList();

                if (filteredProviders.isEmpty) {
                  return const Center(child: Text('No providers found'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredProviders.length,
                  itemBuilder: (context, index) {
                    final provider = filteredProviders[index];
                    return _buildProviderCard(context, provider);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProviderCard(BuildContext context, ProviderSummaryEntity provider) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ServiceImageWidget(
          imageUrl: provider.photoUrl,
          width: 60,
          height: 60,
          borderRadius: BorderRadius.circular(30),
          placeholderIcon: Icons.person,
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                provider.businessName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            if (provider.isVerified)
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Icon(Icons.verified_rounded, color: AppColors.primary, size: 14),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star_rounded, color: AppColors.warning, size: 14),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    '${provider.rating} (${provider.reviewCount})',
                    style: const TextStyle(fontSize: 10),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.location_on_outlined, size: 12, color: Colors.grey.shade500),
                const SizedBox(width: 2),
                Flexible(
                  child: Text(
                    '${provider.distance?.toStringAsFixed(1)} km away',
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(provider.categories.join(', '),
                style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () => context.push(AppRoutes.providerProfilePath(provider.id)),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            visualDensity: VisualDensity.compact,
          ),
          child: const Text('View', style: TextStyle(fontSize: 12)),
        ),
        onTap: () => context.push(AppRoutes.providerProfilePath(provider.id)),
      ),
    );
  }
}

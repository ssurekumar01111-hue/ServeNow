import 'package:customer/core/router/app_routes.dart';
import 'package:customer/core/widgets/cached_image_widget.dart';
import 'package:customer/core/widgets/shimmer_loader.dart';
import 'package:customer/features/services/presentation/providers/services_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CategoryServicesScreen extends ConsumerWidget {
  const CategoryServicesScreen({required this.categoryId, required this.categoryName, super.key});
  final String categoryId;
  final String categoryName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final services = ref.watch(servicesByCategoryProvider(categoryId));

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
        ],
      ),
      body: services.when(
        data: (items) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final service = items[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: ServiceImageWidget(
                  imageUrl: service.images.isNotEmpty ? service.images.first : null,
                  width: 64,
                  height: 64,
                  borderRadius: BorderRadius.circular(8),
                ),
                title: Text(
                  service.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      '₹${service.basePrice.toInt()} • ${service.duration} mins',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                        Text(
                          ' ${service.rating.toStringAsFixed(1)}',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: ElevatedButton(
                  onPressed: () => context.push(AppRoutes.serviceDetailPath(service.id)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    visualDensity: VisualDensity.compact,
                  ),
                  child: const Text('View', style: TextStyle(fontSize: 12)),
                ),
                onTap: () => context.push(AppRoutes.serviceDetailPath(service.id)),
              ),
            );
          },
        ),
        loading: () => const Padding(
          padding: EdgeInsets.all(16),
          child: ShimmerLoader(),
        ),
        error: (e, st) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text('Something went wrong: $e', textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(servicesByCategoryProvider(categoryId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:customer/core/router/app_routes.dart';
import 'package:customer/core/theme/app_colors.dart';
import 'package:customer/features/home/domain/entities/category_entity.dart';
import 'package:customer/features/home/presentation/providers/home_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AllCategoriesScreen extends ConsumerWidget {
  const AllCategoriesScreen({super.key});

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
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('All Categories', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
      ),
      body: categoriesAsync.when(
        data: (categories) => GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final cat = categories[index];
            final color = getCategoryColor(cat.name);
            final icon = getCategoryIcon(cat.name);
            
            return GestureDetector(
              onTap: () => context.push(AppRoutes.categoryServicesPath(cat.id), extra: cat.name),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: cat.iconUrl.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              cat.iconUrl,
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Icon(icon, color: color, size: 32),
                            ),
                          )
                        : Icon(icon, color: color, size: 32),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      cat.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.textPrimary,
                        fontFamily: 'Poppins'
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

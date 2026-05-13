import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/router/app_routes.dart';
import 'package:customer/features/booking/presentation/providers/booking_providers.dart';
import 'package:customer/features/home/domain/entities/provider_summary_entity.dart';
import 'package:customer/features/services/presentation/providers/services_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ServiceDetailScreen extends ConsumerStatefulWidget {
  const ServiceDetailScreen({required this.serviceId, super.key});
  final String serviceId;

  @override
  ConsumerState<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends ConsumerState<ServiceDetailScreen> {
  String _selectedProviderId = ''; // Empty means 'Any available'
  String _selectedProviderName = 'Any available provider';

  @override
  Widget build(BuildContext context) {
    final serviceAsync = ref.watch(serviceDetailProvider(widget.serviceId));

    return serviceAsync.when(
      data: (service) {
        if (service == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Not Found')),
            body: const Center(child: Text('Service not found')),
          );
        }

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: Colors.blueGrey,
                    child: service.imageUrl != null && service.imageUrl!.isNotEmpty
                        ? Image.network(service.imageUrl!, fit: BoxFit.cover)
                        : const Icon(Icons.home_repair_service, size: 64, color: Colors.white24),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(service.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(service.description),
                      const SizedBox(height: 24),
                      const Text('Select Provider', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      
                      // Any Available Provider Option
                      _buildProviderCard(
                        id: '',
                        name: 'Any available provider',
                        photoUrl: '',
                        rating: 0,
                        reviewCount: 0,
                        serviceArea: "We'll assign the best match",
                        isSelected: _selectedProviderId == '',
                        onTap: () {
                          setState(() {
                            _selectedProviderId = '';
                            _selectedProviderName = 'Any available provider';
                          });
                        },
                      ),
                      
                      const SizedBox(height: 12),
                      const Text('Available Providers', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey)),
                      const SizedBox(height: 8),
                      
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('providers')
                            .where('categories', arrayContains: service.categoryId)
                            .where('onboardingStatus', isEqualTo: 'approved')
                            .where('isActive', isEqualTo: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Text('Error loading providers: ${snapshot.error}');
                          }
                          
                          final docs = snapshot.data?.docs ?? [];
                          if (docs.isEmpty) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text('No specific providers found for this service area.', style: TextStyle(fontStyle: FontStyle.italic)),
                            );
                          }
                          
                          return Column(
                            children: docs.map((doc) {
                              final data = doc.data() as Map<String, dynamic>;
                              final provider = ProviderSummaryEntity(
                                id: doc.id,
                                businessName: (data['businessName'] ?? 'Business Name').toString(),
                                rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
                                reviewCount: (data['reviewCount'] as num?)?.toInt() ?? 0,
                                photoUrl: (data['photoUrl'] ?? '').toString(),
                                categories: (data['categories'] as List?)?.map((e) => e.toString()).toList() ?? <String>[],
                                serviceArea: data['serviceArea']?.toString(),
                                isActive: data['isActive'] as bool? ?? true,
                                onboardingStatus: data['onboardingStatus']?.toString(),
                              );
                              
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _buildProviderCard(
                                  id: provider.id,
                                  name: provider.businessName,
                                  photoUrl: provider.photoUrl,
                                  rating: provider.rating,
                                  reviewCount: provider.reviewCount,
                                  serviceArea: provider.serviceArea ?? 'Service area not specified',
                                  isSelected: _selectedProviderId == provider.id,
                                  onTap: () {
                                    setState(() {
                                      _selectedProviderId = provider.id;
                                      _selectedProviderName = provider.businessName;
                                    });
                                  },
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            height: 90,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Base Price', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        Text('₹${service.basePrice}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        ref.read(createBookingProvider.notifier).updateProvider(_selectedProviderId, _selectedProviderName);
                        context.push(AppRoutes.bookingForm, extra: service);
                      },
                      child: const Text('Book Now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, st) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildProviderCard({
    required String id,
    required String name,
    required String photoUrl,
    required double rating,
    required int reviewCount,
    required String serviceArea,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: photoUrl.isNotEmpty ? NetworkImage(photoUrl) : null,
              child: photoUrl.isEmpty ? const Icon(Icons.person) : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text('$rating ($reviewCount reviews)', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          serviceArea,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.blue)
            else
              const Icon(Icons.circle_outlined, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

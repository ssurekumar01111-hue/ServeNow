import 'package:customer/core/widgets/cached_image_widget.dart';
import 'package:customer/features/reviews/presentation/review_providers.dart';
import 'package:customer/features/services/presentation/providers/services_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ProviderProfileScreen extends ConsumerWidget {
  const ProviderProfileScreen({required this.providerId, super.key});
  final String providerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerDetail = ref.watch(providerDetailProvider(providerId));
    final reviewsAsync = ref.watch(providerReviewsProvider(providerId));

    return Scaffold(
      appBar: AppBar(title: const Text('Provider Profile')),
      body: providerDetail.when(
        data: (item) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ServiceImageWidget(
                    imageUrl: item.photoUrl,
                    width: double.infinity,
                    height: 200,
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.4),
                    child: Center(
                      child: ClipOval(
                        child: ServiceImageWidget(
                          imageUrl: item.photoUrl,
                          width: 100,
                          height: 100,
                          placeholderIcon: Icons.person,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.businessName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, color: Colors.orange),
                        Text(' ${item.rating} (${item.reviewCount} reviews)'),
                        const SizedBox(width: 8),
                        if (item.isVerified) const Icon(Icons.verified_rounded, color: Colors.blue),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('About', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(item.description ?? ''),
                    const SizedBox(height: 24),
                    const Text('Services', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: item.services.length,
                      itemBuilder: (context, index) {
                        final service = item.services[index];
                        return ListTile(
                          title: Text(service.name),
                          subtitle: Text('₹${service.basePrice.toInt()}'),
                          contentPadding: EdgeInsets.zero,
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    const Text('Reviews', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    reviewsAsync.when(
                      data: (reviews) {
                        if (reviews.isEmpty) {
                          return const Text('No reviews yet.', style: TextStyle(color: Colors.grey));
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: reviews.length,
                          itemBuilder: (context, index) {
                            final review = reviews[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        ...List.generate(5, (i) => Icon(
                                          i < review.providerRating ? Icons.star_rounded : Icons.star_border_rounded,
                                          size: 16,
                                          color: Colors.amber,
                                        )),
                                        const Spacer(),
                                        Text(
                                          DateFormat('dd MMM yyyy').format(review.createdAt),
                                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(review.comment ?? ''),
                                    if (review.photos.isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: SizedBox(
                                          height: 60,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: review.photos.length,
                                            itemBuilder: (context, i) => Padding(
                                              padding: const EdgeInsets.only(right: 8),
                                              child: ServiceImageWidget(
                                                imageUrl: review.photos[i] ?? '',
                                                width: 60,
                                                height: 60,
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (e, st) => Text('Error loading reviews: $e'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}


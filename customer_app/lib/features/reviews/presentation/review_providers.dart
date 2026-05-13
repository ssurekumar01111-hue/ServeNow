import 'dart:async';
import 'package:customer/features/reviews/data/review_remote_data_source.dart';
import 'package:customer/features/reviews/domain/review_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> createReview(ReviewEntity review) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(reviewDataSourceProvider).createReview(review));
  }
}

final reviewNotifierProvider = AsyncNotifierProvider<ReviewNotifier, void>(ReviewNotifier.new);

class ProviderReviewsNotifier extends FamilyStreamNotifier<List<ReviewEntity>, String> {
  @override
  Stream<List<ReviewEntity>> build(String arg) {
    return ref.watch(reviewDataSourceProvider).getProviderReviews(arg);
  }
}

final providerReviewsProvider = StreamNotifierProvider.family<ProviderReviewsNotifier, List<ReviewEntity>, String>(ProviderReviewsNotifier.new);

final hasReviewedProvider = FutureProvider.family<bool, String>((ref, bookingId) {
  return ref.watch(reviewDataSourceProvider).hasCustomerReviewed(bookingId);
});

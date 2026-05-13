import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/features/reviews/domain/review_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewRemoteDataSource {
  final FirebaseFirestore _firestore;

  ReviewRemoteDataSource(this._firestore);

  Future<void> createReview(ReviewEntity review) async {
    final batch = _firestore.batch();
    
    // 1. Create rating doc in 'ratings' collection
    final ratingRef = _firestore.collection('ratings').doc();
    batch.set(ratingRef, {
      'bookingId': review.bookingId,
      'customerId': review.customerId,
      'customerName': review.customerName,
      'providerId': review.providerId,
      'handymanId': review.handymanId,
      'providerRating': review.providerRating,
      'handymanRating': review.handymanRating,
      'review': review.comment,
      'images': review.photos,
      'isVisible': true,
      'createdAt': FieldValue.serverTimestamp(),
    });

    // 2. Update booking doc
    final bookingRef = _firestore.collection('bookings').doc(review.bookingId);
    batch.update(bookingRef, {
      'rating': review.providerRating, // Use provider rating as main booking rating
      'review': review.comment,
      'hasBeenRated': true,
      'isRated': true,
    });

    // 3. Update provider rating
    final providerRef = _firestore.collection('providers').doc(review.providerId);
    batch.update(providerRef, {
      'totalRatings': FieldValue.increment(1),
      'rating': review.providerRating, // This is simplified; ideally needs a cloud function for true average
    });

    // 4. Update handyman rating if exists
    if (review.handymanId != null && review.handymanId!.isNotEmpty) {
      final handymanRef = _firestore.collection('handymen').doc(review.handymanId);
      batch.update(handymanRef, {
        'totalRatings': FieldValue.increment(1),
        'rating': review.handymanRating,
      });
    }

    await batch.commit();
  }

  Stream<List<ReviewEntity>> getProviderReviews(String providerId) {
    return _firestore
        .collection('ratings')
        .where('providerId', isEqualTo: providerId)
        .where('isVisible', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return ReviewEntity(
          id: doc.id,
          bookingId: (data['bookingId'] as String? ?? ''),
          customerId: (data['customerId'] as String? ?? ''),
          customerName: (data['customerName'] as String? ?? 'Customer'),
          providerId: (data['providerId'] as String? ?? ''),
          handymanId: (data['handymanId'] as String?),
          providerRating: (data['providerRating'] as num? ?? 0).toDouble(),
          handymanRating: (data['handymanRating'] as num? ?? 0).toDouble(),
          comment: (data['review'] as String? ?? ''),
          photos: List<String>.from(data['images'] as Iterable? ?? []),
          isVisible: (data['isVisible'] as bool? ?? true),
          createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
        );
      }).toList();
    });
  }

  Future<bool> hasCustomerReviewed(String bookingId) async {
    final snapshot = await _firestore
        .collection('ratings')
        .where('bookingId', isEqualTo: bookingId)
        .limit(1)
        .get();
    return snapshot.docs.isNotEmpty;
  }
}

final reviewDataSourceProvider = Provider((ref) {
  return ReviewRemoteDataSource(FirebaseFirestore.instance);
});

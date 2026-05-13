import 'dart:async';
import 'package:get/get.dart';
import 'package:admin_web/app/models/rating_model.dart';
import 'package:admin_web/app/utils/fire_store_utils.dart';

class RatingsController extends GetxController {
  final allRatings = <RatingModel>[].obs;
  final filteredRatings = <RatingModel>[].obs;
  final ratingFilter = 'all'.obs;
  final isLoading = true.obs;
  StreamSubscription? _sub;

  @override
  void onInit() {
    super.onInit();
    listenToRatings();
  }

  void listenToRatings() {
    _sub = FireStoreUtils.getRatingsStream().listen((snapshot) {
      allRatings.value = snapshot.docs
          .map((doc) => RatingModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      applyFilters();
      isLoading.value = false;
    });
  }

  void applyFilters() {
    if (ratingFilter.value == 'all') {
      filteredRatings.value = allRatings;
    } else {
      final targetScore = double.tryParse(ratingFilter.value) ?? 0;
      filteredRatings.value = allRatings.where((r) => r.providerRating == targetScore || r.handymanRating == targetScore).toList();
    }
  }

  void setFilter(String val) {
    ratingFilter.value = val;
    applyFilters();
  }

  Future<void> toggleVisibility(String id, bool isVisible) async {
    await FireStoreUtils.toggleRatingVisibility(id, isVisible);
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}

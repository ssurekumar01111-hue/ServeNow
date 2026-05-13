import 'package:customer/features/home/domain/entities/banner_entity.dart';
import 'package:customer/features/home/domain/entities/category_entity.dart';
import 'package:customer/features/home/domain/entities/provider_summary_entity.dart';

abstract class HomeRepository {
  Stream<List<CategoryEntity>> getCategories();
  Stream<List<BannerEntity>> getBanners();
  Stream<List<ProviderSummaryEntity>> getNearbyProviders(double lat, double lng);
}

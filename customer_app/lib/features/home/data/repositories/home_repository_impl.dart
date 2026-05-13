import 'package:customer/features/home/data/datasources/home_remote_datasource.dart';
import 'package:customer/features/home/domain/entities/banner_entity.dart';
import 'package:customer/features/home/domain/entities/category_entity.dart';
import 'package:customer/features/home/domain/entities/provider_summary_entity.dart';
import 'package:customer/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this.remoteDataSource);
  final HomeRemoteDataSource remoteDataSource;

  @override
  Stream<List<CategoryEntity>> getCategories() {
    return remoteDataSource.getCategories().map(
          (models) => models.map((e) => e.toEntity()).toList(),
        );
  }

  @override
  Stream<List<BannerEntity>> getBanners() {
    return remoteDataSource.getBanners().map(
          (models) => models.map((e) => e.toEntity()).toList(),
        );
  }

  @override
  Stream<List<ProviderSummaryEntity>> getNearbyProviders(double lat, double lng) {
    return remoteDataSource.getNearbyProviders(lat, lng).map(
          (models) => models.map((e) => e.toEntity()).toList(),
        );
  }
}

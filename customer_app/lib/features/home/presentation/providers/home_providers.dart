import 'package:customer/core/providers/firebase_providers.dart';
import 'package:customer/features/home/data/datasources/home_remote_datasource.dart';
import 'package:customer/features/home/data/repositories/home_repository_impl.dart';
import 'package:customer/features/home/domain/entities/banner_entity.dart';
import 'package:customer/features/home/domain/entities/category_entity.dart';
import 'package:customer/features/home/domain/entities/provider_summary_entity.dart';
import 'package:customer/features/home/domain/repositories/home_repository.dart';
import 'package:customer/features/home/presentation/providers/location_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeRemoteDataSourceProvider = Provider<HomeRemoteDataSource>((ref) {
  return HomeRemoteDataSourceImpl(ref.watch(firestoreProvider));
});

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepositoryImpl(ref.watch(homeRemoteDataSourceProvider));
});

final categoriesProvider = StreamProvider<List<CategoryEntity>>((ref) {
  return ref.watch(homeRepositoryProvider).getCategories();
});

final bannersProvider = StreamProvider<List<BannerEntity>>((ref) {
  return ref.watch(homeRepositoryProvider).getBanners();
});

final nearbyProvidersProvider = StreamProvider<List<ProviderSummaryEntity>>((ref) {
  final locationAsync = ref.watch(locationProvider);
  
  return locationAsync.when(
    data: (location) => ref.watch(homeRepositoryProvider).getNearbyProviders(
      location.lat,
      location.lng,
    ),
    loading: () => Stream.value(<ProviderSummaryEntity>[]),
    error: (_, __) => Stream.value(<ProviderSummaryEntity>[]),
  );
});

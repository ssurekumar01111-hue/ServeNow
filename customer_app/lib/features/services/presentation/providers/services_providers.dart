import 'package:customer/core/providers/firebase_providers.dart';
import 'package:customer/features/services/data/datasources/services_remote_datasource.dart';
import 'package:customer/features/services/data/repositories/services_repository_impl.dart';
import 'package:customer/features/services/domain/entities/provider_detail_entity.dart';
import 'package:customer/features/services/domain/entities/service_entity.dart';
import 'package:customer/features/services/domain/repositories/services_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final servicesRemoteDataSourceProvider = Provider<ServicesRemoteDataSource>((ref) {
  return ServicesRemoteDataSourceImpl(ref.watch(firestoreProvider));
});

final servicesRepositoryProvider = Provider<ServicesRepository>((ref) {
  return ServicesRepositoryImpl(ref.watch(servicesRemoteDataSourceProvider));
});

final servicesByCategoryProvider = StreamProvider.family<List<ServiceEntity>, String>((ref, categoryId) {
  return ref.watch(servicesRepositoryProvider).getServicesByCategory(categoryId);
});

final allServicesProvider = StreamProvider<List<ServiceEntity>>((ref) {
  return ref.watch(servicesRepositoryProvider).getAllServices();
});

final popularServicesProvider = StreamProvider<List<ServiceEntity>>((ref) {
  return ref.watch(servicesRepositoryProvider).getPopularServices();
});

final providerDetailProvider = StreamProvider.family<ProviderDetailEntity, String>((ref, providerId) {
  return ref.watch(servicesRepositoryProvider).getProviderDetail(providerId);
});

final serviceDetailProvider = StreamProvider.family<ServiceEntity?, String>((ref, serviceId) {
  return ref.watch(servicesRepositoryProvider).getServiceById(serviceId);
});

final providersByCategoryProvider = StreamProvider.family<List<ProviderDetailEntity>, String>((ref, categoryId) {
  return ref.watch(servicesRepositoryProvider).getProvidersByCategory(categoryId);
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchServicesProvider = StreamProvider<List<ServiceEntity>>((ref) {
  final query = ref.watch(searchQueryProvider);
  return ref.watch(servicesRepositoryProvider).searchServices(query);
});

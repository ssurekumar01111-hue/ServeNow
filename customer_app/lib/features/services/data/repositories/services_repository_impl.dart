import 'package:customer/features/services/data/datasources/services_remote_datasource.dart';
import 'package:customer/features/services/domain/entities/provider_detail_entity.dart';
import 'package:customer/features/services/domain/entities/service_entity.dart';
import 'package:customer/features/services/domain/repositories/services_repository.dart';

class ServicesRepositoryImpl implements ServicesRepository {
  ServicesRepositoryImpl(this.remoteDataSource);
  final ServicesRemoteDataSource remoteDataSource;

  @override
  Stream<List<ServiceEntity>> getServicesByCategory(String categoryId) {
    return remoteDataSource
        .getServicesByCategory(categoryId)
        .map((models) => models.map((e) => e.toEntity()).toList());
  }

  @override
  Stream<List<ServiceEntity>> getAllServices() {
    return remoteDataSource
        .getAllServices()
        .map((models) => models.map((e) => e.toEntity()).toList());
  }

  @override
  Stream<List<ServiceEntity>> getPopularServices() {
    return remoteDataSource
        .getPopularServices()
        .map((models) => models.map((e) => e.toEntity()).toList());
  }

  @override
  Stream<ProviderDetailEntity> getProviderDetail(String providerId) {
    return remoteDataSource
        .getProviderDetail(providerId)
        .map((model) => model.toEntity());
  }

  @override
  Stream<ServiceEntity?> getServiceById(String serviceId) {
    return remoteDataSource
        .getServiceById(serviceId)
        .map((model) => model?.toEntity());
  }

  @override
  Stream<List<ProviderDetailEntity>> getProvidersByCategory(String categoryId) {
    return remoteDataSource
        .getProvidersByCategory(categoryId)
        .map((models) => models.map((m) => m.toEntity()).toList());
  }

  @override
  Stream<List<ServiceEntity>> searchServices(String query) {
    return remoteDataSource
        .searchServices(query)
        .map((models) => models.map((e) => e.toEntity()).toList());
  }
}

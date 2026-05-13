import 'package:customer/features/services/domain/entities/provider_detail_entity.dart';
import 'package:customer/features/services/domain/entities/service_entity.dart';

abstract class ServicesRepository {
  Stream<List<ServiceEntity>> getServicesByCategory(String categoryId);
  Stream<List<ServiceEntity>> getAllServices();
  Stream<List<ServiceEntity>> getPopularServices();
  Stream<ProviderDetailEntity> getProviderDetail(String providerId);
  Stream<ServiceEntity?> getServiceById(String serviceId);
  Stream<List<ProviderDetailEntity>> getProvidersByCategory(String categoryId);
  Stream<List<ServiceEntity>> searchServices(String query);
}

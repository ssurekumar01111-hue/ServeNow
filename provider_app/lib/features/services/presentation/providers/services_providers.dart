import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/core/providers/firebase_providers.dart';
import 'package:provider/features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/features/services/data/datasources/services_remote_datasource.dart';
import 'package:provider/features/services/domain/entities/service_entity.dart';

final servicesRemoteDataSourceProvider = Provider<ServicesRemoteDataSource>((ref) {
  return ServicesRemoteDataSourceImpl(ref.watch(firestoreProvider));
});

final providerServicesProvider = AsyncNotifierProvider<ProviderServicesNotifier, List<ServiceEntity>>(ProviderServicesNotifier.new);

class ProviderServicesNotifier extends AsyncNotifier<List<ServiceEntity>> {
  @override
  Future<List<ServiceEntity>> build() async {
    final user = ref.watch(authNotifierProvider).value;
    if (user == null) return [];
    return ref.watch(servicesRemoteDataSourceProvider).getMyServices(user.uid);
  }

  Future<void> addService(ServiceEntity service) async {
    final user = ref.read(authNotifierProvider).value!;
    await ref.read(servicesRemoteDataSourceProvider).addService(service, user.uid);
    ref.invalidateSelf();
  }

  Future<void> toggleStatus(String serviceId, bool isActive) async {
    await ref.read(servicesRemoteDataSourceProvider).toggleServiceStatus(serviceId, isActive);
    ref.invalidateSelf();
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/core/providers/firebase_providers.dart';
import 'package:provider/features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/features/registration/data/datasources/registration_remote_datasource.dart';

final registrationRemoteDataSourceProvider = Provider<RegistrationRemoteDataSource>((ref) {
  return RegistrationRemoteDataSourceImpl(ref.watch(firestoreProvider));
});

final registrationNotifierProvider = AsyncNotifierProvider<RegistrationNotifier, void>(RegistrationNotifier.new);

class RegistrationNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> register(Map<String, dynamic> data) async {
    state = const AsyncLoading();
    try {
      final user = ref.read(authNotifierProvider).value!;
      await ref.read(registrationRemoteDataSourceProvider).registerProvider(user.uid, data);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

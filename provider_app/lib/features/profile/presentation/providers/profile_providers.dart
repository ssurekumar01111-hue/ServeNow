import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/core/providers/firebase_providers.dart';
import 'package:provider/features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:provider/features/profile/domain/entities/provider_profile_entity.dart';

final profileRemoteDataSourceProvider = Provider<ProfileRemoteDataSource>((ref) {
  return ProfileRemoteDataSourceImpl(ref.watch(firestoreProvider));
});

final providerProfileProvider = AsyncNotifierProvider<ProviderProfileNotifier, ProviderProfileEntity?>(ProviderProfileNotifier.new);

class ProviderProfileNotifier extends AsyncNotifier<ProviderProfileEntity?> {
  @override
  Future<ProviderProfileEntity?> build() async {
    final user = ref.watch(authNotifierProvider).value;
    if (user == null) return null;
    return ref.watch(profileRemoteDataSourceProvider).getProfile(user.uid);
  }

  Future<void> updateProfile(ProviderProfileEntity profile) async {
    await ref.read(profileRemoteDataSourceProvider).updateProfile(profile);
    ref.invalidateSelf();
  }
}

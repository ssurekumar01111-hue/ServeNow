import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/core/providers/firebase_providers.dart';
import 'package:provider/features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/features/handymen/domain/entities/handyman_entity.dart';
import 'package:provider/features/handymen/data/datasources/handymen_remote_datasource.dart';

final handymenRemoteDataSourceProvider = Provider<HandymenRemoteDataSource>((ref) {
  return HandymenRemoteDataSourceImpl(ref.watch(firestoreProvider));
});

final myHandymenProvider = AsyncNotifierProvider<MyHandymenNotifier, List<HandymanEntity>>(MyHandymenNotifier.new);

class MyHandymenNotifier extends AsyncNotifier<List<HandymanEntity>> {
  @override
  Future<List<HandymanEntity>> build() async {
    final user = ref.watch(authNotifierProvider).value;
    if (user == null) return [];
    return ref.watch(handymenRemoteDataSourceProvider).getMyHandymen(user.uid);
  }

  Future<void> addHandyman(HandymanEntity handyman) async {
    await ref.read(handymenRemoteDataSourceProvider).addHandyman(handyman);
    ref.invalidateSelf();
  }
}

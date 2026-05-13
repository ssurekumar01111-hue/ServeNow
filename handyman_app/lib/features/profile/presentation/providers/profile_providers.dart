import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/core/providers/firebase_providers.dart';
import 'package:handyman/core/services/location_service.dart';
import 'package:handyman/features/auth/presentation/providers/auth_provider.dart';
import 'package:handyman/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:handyman/features/profile/domain/entities/handyman_profile_entity.dart';

final profileRemoteDataSourceProvider = Provider<ProfileRemoteDataSource>((ref) {
  return ProfileRemoteDataSourceImpl(
    ref.watch(firestoreProvider),
    ref.watch(firebaseStorageProvider),
  );
});

final handymanProfileProvider = StreamProvider<HandymanProfileEntity?>((ref) {
  final user = ref.watch(authNotifierProvider).value;
  if (user == null) return Stream.value(null);
  return ref.watch(profileRemoteDataSourceProvider).getProfile(user.uid).map((profile) {
    if (profile == null) {
      // Return an 'empty' profile so UI doesn't show Error loading
      return HandymanProfileEntity(
        id: user.uid,
        name: '',
        phone: user.phone ?? '',
        skills: [],
        serviceArea: '',
        photoUrl: '',
        email: '',
        rating: 0.0,
        totalRatings: 0,
        commissionRate: 0,
        walletBalance: 0.0,
        totalEarnings: 0.0,
        cashCollected: 0.0,
        isOnline: false,
        isApproved: false,
        onboardingStatus: '',
        providerId: '',
      );
    }
    return profile;
  });
});

final profileNotifierProvider = AsyncNotifierProvider<ProfileNotifier, void>(ProfileNotifier.new);

class ProfileNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> toggleOnline(bool isOnline) async {
    final user = ref.read(authNotifierProvider).value!;
    await ref.read(profileRemoteDataSourceProvider).updateOnlineStatus(user.uid, isOnline);
    
    if (isOnline) {
      await LocationService.startLiveTracking(user.uid);
    } else {
      await LocationService.stopLiveTracking();
    }
  }

  Future<void> updatePhoto(File photo) async {
    state = const AsyncLoading();
    try {
      final user = ref.read(authNotifierProvider).value!;
      await ref.read(profileRemoteDataSourceProvider).updateProfilePhoto(user.uid, photo);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

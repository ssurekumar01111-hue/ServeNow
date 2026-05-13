import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/core/providers/firebase_providers.dart';
import 'package:provider/features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/features/notifications/domain/entities/notification_entity.dart';
import 'package:provider/features/notifications/data/datasources/notifications_remote_datasource.dart';

final notificationsRemoteDataSourceProvider = Provider<NotificationsRemoteDataSource>((ref) {
  return NotificationsRemoteDataSourceImpl(ref.watch(firestoreProvider));
});

final notificationsProvider = StreamProvider<List<NotificationEntity>>((ref) {
  final user = ref.watch(authNotifierProvider).value;
  if (user == null) return const Stream.empty();
  return ref.watch(notificationsRemoteDataSourceProvider).getNotifications(user.uid);
});

final unreadNotificationsCountProvider = Provider<int>((ref) {
  final notifications = ref.watch(notificationsProvider).value ?? [];
  return notifications.where((n) => !n.isRead).length;
});

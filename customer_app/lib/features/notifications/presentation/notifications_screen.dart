import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/router/app_routes.dart';
import 'package:customer/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

class NotificationItem {
  final String id;
  final String title;
  final String body;
  final String? bookingId;
  final bool isRead;
  final DateTime createdAt;

  NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    this.bookingId,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationItem.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NotificationItem(
      id: doc.id,
      title: (data['title'] as String? ?? ''),
      body: (data['body'] as String? ?? ''),
      bookingId: data['bookingId'] as String?,
      isRead: (data['isRead'] as bool? ?? false),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}

final notificationsProvider = StreamProvider<List<NotificationItem>>((ref) {
  final user = ref.watch(authNotifierProvider).value;
  if (user == null) return Stream.value([]);

  return FirebaseFirestore.instance
      .collection('notifications')
      .doc(user.uid)
      .collection('items')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => NotificationItem.fromFirestore(doc)).toList());
});

final unreadNotificationsCountProvider = StreamProvider<int>((ref) {
  final user = ref.watch(authNotifierProvider).value;
  if (user == null) return Stream.value(0);

  return FirebaseFirestore.instance
      .collection('notifications')
      .doc(user.uid)
      .collection('items')
      .where('isRead', isEqualTo: false)
      .snapshots()
      .map((snapshot) => snapshot.docs.length);
});

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    _markAllAsRead();
  }

  Future<void> _markAllAsRead() async {
    final user = ref.read(authNotifierProvider).value;
    if (user == null) return;

    final query = await FirebaseFirestore.instance
        .collection('notifications')
        .doc(user.uid)
        .collection('items')
        .where('isRead', isEqualTo: false)
        .get();

    if (query.docs.isNotEmpty) {
      final batch = FirebaseFirestore.instance.batch();
      for (var doc in query.docs) {
        batch.update(doc.reference, {'isRead': true});
      }
      await batch.commit();
    }
  }

  @override
  Widget build(BuildContext context) {
    final notificationsAsync = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: notificationsAsync.when(
        data: (notifications) {
          if (notifications.isEmpty) {
            return const Center(child: Text('No notifications yet.'));
          }
          return ListView.separated(
            itemCount: notifications.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final item = notifications[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  child: Icon(Icons.notifications_outlined, color: Theme.of(context).primaryColor),
                ),
                title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.body),
                    const SizedBox(height: 5),
                    Text(
                      DateFormat('dd MMM, hh:mm a').format(item.createdAt),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                onTap: () {
                  if (item.bookingId != null) {
                    context.push(AppRoutes.bookingDetailPath(item.bookingId!));
                  }
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  factory NotificationService() => _instance;
  NotificationService._internal();
  static final NotificationService _instance = NotificationService._internal();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> init(Function(String type, String id)? onNotificationTap) async {
    if (_initialized) return;

    // Request permission
    await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Initialize local notifications
    const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOS = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null) {
          final parts = response.payload!.split(':');
          if (parts.length >= 2) {
            onNotificationTap?.call(parts[0], parts[1]);
          }
        }
      },
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && !kIsWeb) {
        _localNotifications.show(
          id: notification.hashCode,
          title: notification.title,
          body: notification.body,
          notificationDetails: NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: android?.smallIcon,
            ),
          ),
          payload: "${(message.data['type'] as String?) ?? 'booking_update'}:${(message.data['bookingId'] as String?) ?? ''}",
        );
      }
    });

    // Handle background messages when app is opened from notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      onNotificationTap?.call(
        (message.data['type'] as String?) ?? 'booking_update',
        (message.data['bookingId'] as String?) ?? '',
      );
    });

    // Handle initial message if app was closed
    final initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      onNotificationTap?.call(
        (initialMessage.data['type'] as String?) ?? 'booking_update',
        (initialMessage.data['bookingId'] as String?) ?? '',
      );
    }

    _initialized = true;
  }

  Future<void> saveToken(String userId) async {
    String? token = await _fcm.getToken();
    if (token != null) {
      await _updateTokenInFirestore(userId, token);
    }

    // Subscribe to topics
    await _fcm.subscribeToTopic('customers');
    await _fcm.subscribeToTopic('all_users');

    // Listen to token refresh
    _fcm.onTokenRefresh.listen((newToken) {
      _updateTokenInFirestore(userId, newToken);
    });
  }

  Future<void> _updateTokenInFirestore(String userId, String token) async {
    try {
      await FirebaseFirestore.instance.collection('customers').doc(userId).set({
        'fcmToken': token,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      
      // Also update in 'users' for backward compatibility if needed, 
      // but Step 4 says customers/{uid}
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error saving token: $e');
      }
    }
  }

  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    if (kDebugMode) {
      debugPrint("Handling a background message: ${message.messageId}");
    }
  }
}

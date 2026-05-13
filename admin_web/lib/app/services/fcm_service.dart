import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> initialize() async {
    await _messaging.requestPermission();
    String? token = await _messaging.getToken();
    print('FCM Token: $token');
  }

  static Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
  }
}

import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// SHA1: 44:D8:43:5A:F3:E2:A1:1F:61:84:C8:94:53:30:D8:8A:0C:24:34:4F

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messageStreamController =
      StreamController.broadcast();
  static Stream<String> get messageStream => _messageStreamController.stream;

  static Future<void> _onBackgroundHandler(RemoteMessage message) async {
    // print('onBackgroundHandler ${message.messageId}');
    print(message.data);
    _messageStreamController.add(message.data['product'] ?? 'No Data');
  }

  static Future<void> _onMessageHandler(RemoteMessage message) async {
    // print('onMessageHandler ${message.messageId}');
    print(message.data);
    _messageStreamController.add(message.data['product'] ?? 'No Data');
  }

  static Future<void> _onMessageOpenApp(RemoteMessage message) async {
    // print('onMessageOpenApp Handler ${message.messageId}');
    print(message.data);
    _messageStreamController.add(message.data['product'] ?? 'No Data');
  }

  static Future<void> initializeApp() async {
    // Push Notifications
    await Firebase.initializeApp();

    token = await messaging.getToken();
    print('TOKEN: $token');

    // Handlers
    FirebaseMessaging.onBackgroundMessage(_onBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    // Local Notifications
  }

  static void closeStreams() {
    _messageStreamController.close();
  }
}

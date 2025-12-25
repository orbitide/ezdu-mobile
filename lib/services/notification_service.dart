import 'package:firebase_messaging/firebase_messaging.dart';

final _firebaseMessaging = FirebaseMessaging.instance;


Future<void> initPushNotifications() async {
  try {
    await _firebaseMessaging.requestPermission();

    final token = await _firebaseMessaging.getToken();
    print('✅ FCM Token: $token');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      print('📬 Notification Received (Foreground)');
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
      print('Data: ${message.data}');
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      print('👆 Notification Tapped');
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
      print('Data: ${message.data}');
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

      // TODO: Handle navigation here
      // final route = message.data['route'];
      // if (route == 'achievements') {
      //   navigateTo('/achievements');
      // }
    });

    // Handle app opened from terminated state
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      print('❄️  App Opened from Terminated State');
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      print('Title: ${initialMessage.notification?.title}');
      print('Body: ${initialMessage.notification?.body}');
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    }

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);

    print('✅ Push Notifications Initialized');
  } catch (e) {
    print('❌ Error initializing push notifications: $e');
  }
}

@pragma('vm:entry-point')
Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  print('🔔 Background Message: ${message.notification?.title}');
}







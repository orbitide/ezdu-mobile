import 'package:ezdu/app/di/injector.dart';
import 'package:ezdu/data/repositories/notification_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/legacy.dart';

class NotificationState {
  final bool isInitialized;
  final String? fcmToken;
  final RemoteMessage? lastNotification;
  final String? error;

  const NotificationState({
    required this.isInitialized,
    this.fcmToken,
    this.lastNotification,
    this.error,
  });

  const NotificationState.initial()
    : isInitialized = false,
      fcmToken = null,
      lastNotification = null,
      error = null;

  NotificationState copyWithInitializing() {
    return NotificationState(
      isInitialized: false,
      fcmToken: fcmToken,
      lastNotification: lastNotification,
      error: null,
    );
  }

  NotificationState copyWithSuccess(String token, {bool? initialized}) {
    return NotificationState(
      isInitialized: initialized == true,
      fcmToken: token,
      lastNotification: lastNotification,
      error: null,
    );
  }

  NotificationState copyWithError(String errorMsg) {
    return NotificationState(
      isInitialized: false,
      fcmToken: fcmToken,
      lastNotification: lastNotification,
      error: errorMsg,
    );
  }

  NotificationState copyWithNotification(RemoteMessage notification) {
    return NotificationState(
      isInitialized: isInitialized,
      fcmToken: fcmToken,
      lastNotification: notification,
      error: error,
    );
  }

  NotificationState copyWithTokenRefresh(String newToken) {
    return NotificationState(
      isInitialized: isInitialized,
      fcmToken: newToken,
      lastNotification: lastNotification,
      error: error,
    );
  }
}

class NotificationNotifier extends StateNotifier<NotificationState> {
  NotificationNotifier(this._repository)
    : super(const NotificationState.initial());

  final NotificationRepository _repository;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool _isInitializing = false;

  Future<void> initialize() async {
    if (_isInitializing || state.isInitialized) {
      return;
    }
    _isInitializing = true;

    try {
      // print('✅ initializing notifications...........');
      state = state.copyWithInitializing();

      await _firebaseMessaging.requestPermission();

      final token = await _firebaseMessaging.getToken();

      if (token == null) {
        state = state.copyWithError('Failed to get FCM token');
        _isInitializing = false;
        return;
      }

      state = state.copyWithSuccess(token);
      // print('✅ FCM Token: $token');

      _setupListeners();

      final initialMessage = await _firebaseMessaging.getInitialMessage();
      if (initialMessage != null) {
        state = state.copyWithNotification(initialMessage);
      }
    } catch (e) {
      state = state.copyWithError(e.toString());
      _isInitializing = false;
      print('❌ Error initializing notifications: $e');
    }
  }

  void _setupListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      print('📬 Notification Received (Foreground)');
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
      print('Data: ${message.data}');
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

      state = state.copyWithNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      print('👆 Notification Tapped (Background)');
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
      print('Data: ${message.data}');
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

      state = state.copyWithNotification(message);
    });

    _firebaseMessaging.onTokenRefresh.listen((String newToken) {
      // print('✅ FCM Token Refreshed: $newToken');
      state = state.copyWithTokenRefresh(newToken);
    });

    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  }

  void clearLastNotification() {
    state = NotificationState(
      isInitialized: state.isInitialized,
      fcmToken: state.fcmToken,
      lastNotification: null,
      error: state.error,
    );
  }

  Future<void> syncToken() async {
    // Safety check: Need a token to sync
    if (state.fcmToken == null || state.isInitialized) {
      // print("⚠️ Cannot sync: No FCM Token available yet.");
      return;
    }

    try {
      // print("🔄 Syncing FCM Token for user...");
      final result = await _repository.syncFcmToken(state.fcmToken!);
      if (result.success) {
        state = state.copyWithSuccess(state.fcmToken!, initialized: true);
      }

      // print("✅ Token Synced");
    } catch (e) {
      print("❌ Sync failed: $e");
    }
  }
}

@pragma('vm:entry-point')
Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  print('🔔 Background Message: ${message.notification?.title}');
}

// ============ PROVIDERS ============

final notificationProvider =
    StateNotifierProvider<NotificationNotifier, NotificationState>(
      (ref) => NotificationNotifier(sl()),
    );

// final notificationInitProvider = FutureProvider<void>((ref) async {
//   await ref.read(notificationProvider.notifier).initialize();
// });

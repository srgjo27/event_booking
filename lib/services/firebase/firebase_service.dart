import 'package:event_booking/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// Firebase initialization and configuration service
class FirebaseService {
  static FirebaseMessaging? _messaging;
  static String? _fcmToken;

  /// Get Firebase Messaging instance
  static FirebaseMessaging get messaging {
    assert(_messaging != null, 'Firebase must be initialized first');
    return _messaging!;
  }

  /// Get current FCM token
  static String? get fcmToken => _fcmToken;

  /// Initialize Firebase Core and Messaging
  static Future<void> initialize() async {
    try {
      // Initialize Firebase Core
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // Initialize Firebase Messaging
      await _initializeMessaging();

      if (kDebugMode) {
        print('Firebase initialized successfully');
        print('FCM Token: $_fcmToken');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Firebase initialization failed: $e');
      }
      rethrow;
    }
  }

  /// Initialize Firebase Messaging
  static Future<void> _initializeMessaging() async {
    _messaging = FirebaseMessaging.instance;

    // Set background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Request permissions
    await _requestNotificationPermissions();

    // Get and setup FCM token
    await _setupFcmToken();

    // Setup message listeners
    _setupMessageListeners();
  }

  /// Request notification permissions
  static Future<void> _requestNotificationPermissions() async {
    final settings = await _messaging!.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (kDebugMode) {
      print('Notification permission: ${settings.authorizationStatus}');
    }
  }

  /// Setup FCM token and token refresh listener
  static Future<void> _setupFcmToken() async {
    try {
      // Get initial token
      _fcmToken = await _messaging!.getToken();

      // Listen for token refresh
      _messaging!.onTokenRefresh.listen((newToken) {
        _fcmToken = newToken;
        if (kDebugMode) {
          print('FCM Token refreshed: $newToken');
        }
        // TODO: Send token to your server
        _sendTokenToServer(newToken);
      });
    } catch (e) {
      if (kDebugMode) {
        print('Failed to get FCM token: $e');
      }
    }
  }

  /// Setup message listeners for foreground messages
  static void _setupMessageListeners() {
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Foreground message received: ${message.messageId}');
        print('Title: ${message.notification?.title}');
        print('Body: ${message.notification?.body}');
      }

      // TODO: Handle foreground message (show local notification, update UI, etc.)
      _handleForegroundMessage(message);
    });

    // Handle notification taps when app is in background/terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('App opened from notification: ${message.messageId}');
      }

      // TODO: Navigate to specific screen based on message data
      _handleNotificationTap(message);
    });
  }

  /// Handle foreground messages
  static void _handleForegroundMessage(RemoteMessage message) {
    // Delegate to NotificationService for proper handling
    // This keeps Firebase service focused on Firebase-specific logic
    if (kDebugMode) {
      print('Delegating foreground message to NotificationService');
    }
  }

  /// Handle notification tap
  static void _handleNotificationTap(RemoteMessage message) {
    // Delegate to NotificationService for proper navigation handling
    if (kDebugMode) {
      print('Delegating notification tap to NotificationService');
    }
  }

  /// Send FCM token to server
  static Future<void> _sendTokenToServer(String token) async {
    // TODO: Implement API call to send token to your server
    if (kDebugMode) {
      print('Sending token to server: $token');
    }
  }

  /// Subscribe to topic
  static Future<void> subscribeToTopic(String topic) async {
    try {
      await _messaging!.subscribeToTopic(topic);
      if (kDebugMode) {
        print('Subscribed to topic: $topic');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to subscribe to topic $topic: $e');
      }
    }
  }

  /// Unsubscribe from topic
  static Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _messaging!.unsubscribeFromTopic(topic);
      if (kDebugMode) {
        print('Unsubscribed from topic: $topic');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to unsubscribe from topic $topic: $e');
      }
    }
  }

  /// Get initial message (when app is opened from terminated state)
  static Future<RemoteMessage?> getInitialMessage() async {
    return await _messaging!.getInitialMessage();
  }
}

/// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kDebugMode) {
    print('Background message received: ${message.messageId}');
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
  }

  // TODO: Handle background message
}

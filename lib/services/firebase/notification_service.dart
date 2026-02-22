import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';

/// Notification handling service
class NotificationService {
  static final NavigationService _navigationService =
      locator<NavigationService>();

  /// Handle notification tap when app is opened
  static void handleNotificationTap(RemoteMessage message) {
    if (kDebugMode) {
      print('Handling notification tap: ${message.messageId}');
    }

    final data = message.data;

    // Navigate based on notification data
    if (data.containsKey('event_id')) {
      _navigateToEventDetail(data['event_id']);
    } else if (data.containsKey('screen')) {
      _navigateToScreen(data['screen']);
    } else {
      // Default navigation to main view
      _navigationService.navigateTo(Routes.mainView);
    }
  }

  /// Handle foreground notification
  static void handleForegroundNotification(RemoteMessage message) {
    if (kDebugMode) {
      print('Handling foreground notification: ${message.messageId}');
    }

    // TODO: Show in-app notification or update UI
    // You can use local notifications library here
  }

  /// Navigate to event detail
  static void _navigateToEventDetail(String eventId) {
    // For now, navigate to main view since we need actual Event object
    // TODO: Implement API call to get Event by eventId
    _navigationService.navigateTo(Routes.mainView);

    if (kDebugMode) {
      print('Should navigate to event detail: $eventId');
    }
  }

  /// Navigate to specific screen
  static void _navigateToScreen(String screenName) {
    switch (screenName) {
      case 'main':
      case 'events':
        _navigationService.navigateTo(Routes.mainView);
        break;
      case 'login':
        _navigationService.navigateTo(Routes.loginView);
        break;
      case 'register':
        _navigationService.navigateTo(Routes.registerView);
        break;
      default:
        _navigationService.navigateTo(Routes.mainView);
    }
  }

  /// Subscribe to event-related topics
  static Future<void> subscribeToEventTopics() async {
    // Subscribe to general event updates
    await FirebaseMessaging.instance.subscribeToTopic('events');

    // Subscribe to booking updates
    await FirebaseMessaging.instance.subscribeToTopic('bookings');

    if (kDebugMode) {
      print('Subscribed to event notification topics');
    }
  }

  /// Subscribe to user-specific topics
  static Future<void> subscribeToUserTopics(String userId) async {
    await FirebaseMessaging.instance.subscribeToTopic('user_$userId');

    if (kDebugMode) {
      print('Subscribed to user-specific topics: user_$userId');
    }
  }

  /// Unsubscribe from all topics
  static Future<void> unsubscribeFromAllTopics() async {
    await FirebaseMessaging.instance.unsubscribeFromTopic('events');
    await FirebaseMessaging.instance.unsubscribeFromTopic('bookings');

    if (kDebugMode) {
      print('Unsubscribed from all notification topics');
    }
  }
}

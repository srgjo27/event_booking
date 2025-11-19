import 'package:event_booking/app/app.bottomsheets.dart';
import 'package:event_booking/app/app.dialogs.dart';
import 'package:event_booking/app/app.locator.dart';
import 'package:event_booking/config/app_config.dart';
import 'package:event_booking/config/development_config.dart';
import 'package:event_booking/config/production_config.dart';
import 'package:event_booking/config/staging_config.dart';
import 'package:flutter/foundation.dart';

import 'firebase/firebase_service.dart';
import 'firebase/notification_service.dart';

/// Application initialization service
/// Handles all app setup and configuration in a clean, organized way
class AppInitializer {
  /// Initialize the entire application
  static Future<void> initialize(
      {AppEnvironment environment = AppEnvironment.development}) async {
    try {
      if (kDebugMode) {
        print('Initializing EventHub App...');
      }

      await _initializeAppConfig(environment);
      await _setupDependencyInjection();
      _setupUIComponents();
      await _initializeFirebaseServices();
      await _setupNotificationTopics();

      if (kDebugMode) {
        print('EventHub App initialized successfully!');
      }
    } catch (e) {
      if (kDebugMode) {
        print('App initialization failed: $e');
      }
      rethrow;
    }
  }

  /// Initialize app configuration based on environment
  static Future<void> _initializeAppConfig(AppEnvironment environment) async {
    switch (environment) {
      case AppEnvironment.development:
        AppConfig.initialize(DevelopmentConfig.config);
        break;
      case AppEnvironment.staging:
        AppConfig.initialize(StagingConfig.config);
        break;
      case AppEnvironment.production:
        AppConfig.initialize(ProductionConfig.config);
        break;
    }

    if (kDebugMode) {
      print('App config initialized: ${AppConfig.instance.environment}');
    }
  }

  /// Setup dependency injection
  static Future<void> _setupDependencyInjection() async {
    await setupLocator();

    if (kDebugMode) {
      print('Dependency injection setup completed');
    }
  }

  /// Setup UI components (dialogs, bottom sheets, etc.)
  static void _setupUIComponents() {
    setupDialogUi();
    setupBottomSheetUi();

    if (kDebugMode) {
      print('UI components setup completed');
    }
  }

  /// Initialize Firebase services
  static Future<void> _initializeFirebaseServices() async {
    await FirebaseService.initialize();

    if (kDebugMode) {
      print('Firebase services initialized');
    }
  }

  /// Setup notification topics based on app configuration
  static Future<void> _setupNotificationTopics() async {
    // Subscribe to basic event topics
    await NotificationService.subscribeToEventTopics();

    // Subscribe to environment-specific topics
    if (AppConfig.instance.isDevelopment) {
      await FirebaseService.subscribeToTopic('dev_updates');
    } else if (AppConfig.instance.isStaging) {
      await FirebaseService.subscribeToTopic('staging_updates');
    } else if (AppConfig.instance.isProduction) {
      await FirebaseService.subscribeToTopic('general_updates');
    }

    if (kDebugMode) {
      print('Notification topics setup completed');
    }
  }

  /// Get initial notification message if app was opened from notification
  static Future<void> handleInitialMessage() async {
    final initialMessage = await FirebaseService.getInitialMessage();
    if (initialMessage != null) {
      NotificationService.handleNotificationTap(initialMessage);
    }
  }
}

/// Application environment enum
enum AppEnvironment {
  development,
  staging,
  production,
}

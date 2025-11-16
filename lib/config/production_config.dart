import 'app_config.dart';

class ProductionConfig {
  static AppConfig get config => const AppConfig(
        appName: 'EventHub',
        baseUrl: 'https://api.eventhub.com',
        apiVersion: 'v1',
        isDebugMode: false,
        environment: 'production',
        packageName: 'com.eventhub.app',
        logLevel: 'error',
        enableAnalytics: true,
        enableCrashReporting: true,
        requestTimeoutSeconds: 60,
      );
}

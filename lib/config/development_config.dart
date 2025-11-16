import 'app_config.dart';

class DevelopmentConfig {
  static AppConfig get config => const AppConfig(
        appName: 'EventHub Dev',
        baseUrl: 'https://api-dev.eventhub.com',
        apiVersion: 'v1',
        isDebugMode: true,
        environment: 'development',
        packageName: 'com.eventhub.app.dev',
        logLevel: 'debug',
        enableAnalytics: false,
        enableCrashReporting: false,
        requestTimeoutSeconds: 30,
      );
}

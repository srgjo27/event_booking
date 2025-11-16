import 'app_config.dart';

class StagingConfig {
  static AppConfig get config => const AppConfig(
        appName: 'EventHub Staging',
        baseUrl: 'https://api-staging.eventhub.com',
        apiVersion: 'v1',
        isDebugMode: true,
        environment: 'staging',
        packageName: 'com.eventhub.app.staging',
        logLevel: 'info',
        enableAnalytics: true,
        enableCrashReporting: true,
        requestTimeoutSeconds: 45,
      );
}

class AppConfig {
  final String appName;
  final String baseUrl;
  final String apiVersion;
  final bool isDebugMode;
  final String environment;
  final String packageName;
  final String logLevel;
  final bool enableAnalytics;
  final bool enableCrashReporting;
  final int requestTimeoutSeconds;

  const AppConfig({
    required this.appName,
    required this.baseUrl,
    required this.apiVersion,
    required this.isDebugMode,
    required this.environment,
    required this.packageName,
    required this.logLevel,
    required this.enableAnalytics,
    required this.enableCrashReporting,
    required this.requestTimeoutSeconds,
  });

  static AppConfig? _instance;
  static AppConfig get instance {
    assert(_instance != null, 'AppConfig must be initialized');
    return _instance!;
  }

  static void initialize(AppConfig config) {
    _instance = config;
  }

  bool get isDevelopment => environment == 'development';
  bool get isStaging => environment == 'staging';
  bool get isProduction => environment == 'production';

  @override
  String toString() {
    return 'AppConfig(appName: $appName, environment: $environment, baseUrl: $baseUrl)';
  }
}

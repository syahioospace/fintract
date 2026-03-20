enum AppEnvironment { dev, staging, prod }

class AppConfig {
  final AppEnvironment environment;
  final String apiBaseUrl;
  final String appName;
  final bool enableLoging;

  const AppConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.appName,
    required this.enableLoging,
  });

  static late AppConfig _instance;

  static AppConfig get instance => _instance;

  static void initialize(AppConfig config) {
    _instance = config;
  }

  bool get isDev => environment == AppEnvironment.dev;
  bool get isStaging => environment == AppEnvironment.staging;
  bool get isProd => environment == AppEnvironment.prod;
}

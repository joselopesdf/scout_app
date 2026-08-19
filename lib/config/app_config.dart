import 'app_environment.dart';

final class AppConfig {
  const AppConfig({required this.environment, required this.appName});

  final AppEnvironment environment;
  final String appName;

  bool get isProduction => environment.isProduction;

  bool get enableVerboseLogging => !isProduction;
}

abstract final class AppConfigs {
  static const dev = AppConfig(
    environment: AppEnvironment.dev,
    appName: 'Scout App Dev',
  );

  static const staging = AppConfig(
    environment: AppEnvironment.staging,
    appName: 'Scout App Staging',
  );

  static const prod = AppConfig(
    environment: AppEnvironment.prod,
    appName: 'Scout App',
  );

  static const all = <AppConfig>[dev, staging, prod];

  static AppConfig fromEnvironment(AppEnvironment environment) {
    return switch (environment) {
      AppEnvironment.dev => dev,
      AppEnvironment.staging => staging,
      AppEnvironment.prod => prod,
    };
  }
}

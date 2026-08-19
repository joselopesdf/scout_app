import 'package:flutter_test/flutter_test.dart';
import 'package:scout_app/config/app_config.dart';
import 'package:scout_app/config/app_environment.dart';

void main() {
  group('AppConfigs', () {
    test('contains exactly one config for every supported environment', () {
      final configuredEnvironments = AppConfigs.all
          .map((config) => config.environment)
          .toSet();

      expect(configuredEnvironments, AppEnvironment.values.toSet());
      expect(AppConfigs.all, hasLength(AppEnvironment.values.length));

      for (final config in AppConfigs.all) {
        expect(AppConfigs.fromEnvironment(config.environment), same(config));
      }
    });

    test('uses a distinct visual name for every environment', () {
      final appNames = AppConfigs.all.map((config) => config.appName).toSet();

      expect(appNames, hasLength(AppConfigs.all.length));
      expect(AppConfigs.dev.appName, contains('Dev'));
      expect(AppConfigs.staging.appName, contains('Staging'));
      expect(AppConfigs.prod.appName, 'Scout App');
    });

    test('enables verbose logging only outside production', () {
      expect(AppConfigs.dev.enableVerboseLogging, isTrue);
      expect(AppConfigs.staging.enableVerboseLogging, isTrue);
      expect(AppConfigs.prod.enableVerboseLogging, isFalse);

      expect(AppConfigs.dev.isProduction, isFalse);
      expect(AppConfigs.staging.isProduction, isFalse);
      expect(AppConfigs.prod.isProduction, isTrue);
    });
  });
}

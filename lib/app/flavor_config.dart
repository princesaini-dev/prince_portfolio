class FlavorConfig {
  static const String flavor =
      String.fromEnvironment('FLAVOR', defaultValue: 'debug');

  static bool get isDebug => flavor == 'debug';
  static bool get isProduction => flavor == 'prod';

  static String get appName {
    switch (flavor) {
      case 'prod':
        return 'Prince Portfolio';
      case 'debug':
      default:
        return 'Prince Portfolio (Debug)';
    }
  }
}

enum AppEnvironment {
  dev,
  staging,
  prod;

  bool get isProduction => this == AppEnvironment.prod;
}

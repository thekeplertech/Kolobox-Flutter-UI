enum Flavor { dev, prod }

class FlavorConfig {
  final Flavor flavor;
  final String baseUrl;
  final String payStackKey;
  static FlavorConfig? _instance;

  factory FlavorConfig({
    required Flavor flavor,
    required String baseUrl,
    required String payStackKey,
  }) {
    _instance ??= FlavorConfig._internal(
      flavor,
      baseUrl,
      payStackKey,
    );
    return _instance!;
  }

  FlavorConfig._internal(
    this.flavor,
    this.baseUrl,
    this.payStackKey,
  );

  static FlavorConfig? get instance => _instance;

  static bool isProd() => _instance!.flavor == Flavor.prod;

  static bool isDev() => _instance!.flavor == Flavor.dev;
}

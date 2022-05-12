part of configuration;

enum Flavor { development, staging, release }

class BuildConfig {
  const BuildConfig._({
    required this.baseUrl,
    required this.socketUrl,
    required this.connectTimeout,
    required this.receiveTimeout,
    required this.flavor,
  });

  const BuildConfig._development()
      : this._(
          baseUrl: 'https://6128855786a213001729f948.mockapi.io/api/v1/',
          socketUrl: '',
          connectTimeout: 20000,
          receiveTimeout: 20000,
          flavor: Flavor.development,
        );

  const BuildConfig._staging()
      : this._(
          baseUrl: 'https://6128855786a213001729f948.mockapi.io/api/v1/',
          socketUrl: '',
          connectTimeout: 20000,
          receiveTimeout: 20000,
          flavor: Flavor.staging,
        );

  const BuildConfig._release()
      : this._(
          baseUrl: 'https://6128855786a213001729f948.mockapi.io/api/v1/',
          socketUrl: '',
          connectTimeout: 20000,
          receiveTimeout: 20000,
          flavor: Flavor.release,
        );

  static late BuildConfig _instance;

  static void init({String? flavor}) {
    debugPrint(
        '╔══════════════════════════════════════════════════════════════╗');
    debugPrint(
        '                    Build Flavor: $flavor                       ');
    debugPrint(
        '╚══════════════════════════════════════════════════════════════╝');
    switch (flavor) {
      case 'development':
        _instance = const BuildConfig._development();
        break;
      case 'staging':
        _instance = const BuildConfig._staging();
        break;
      default:
        _instance = const BuildConfig._release();
        break;
    }
    _initLog();
  }

  static BuildConfig get() {
    return _instance;
  }

  static Future<void> _initLog() async {
    await Log.init();
    switch (_instance.flavor) {
      case Flavor.development:
      case Flavor.staging:
        Log.setLevel(Level.ALL);
        break;
      case Flavor.release:
        Log.setLevel(Level.OFF);
        break;
    }
  }

  final String baseUrl;
  final String socketUrl;
  final int connectTimeout;
  final int receiveTimeout;
  final Flavor flavor;

  static String flavorName() =>
      StringUtils.enumToName(_instance.flavor.toString());

  static bool isProduction() => _instance.flavor == Flavor.release;

  static bool isStaging() => _instance.flavor == Flavor.staging;

  static bool isDevelopment() => _instance.flavor == Flavor.development;
}

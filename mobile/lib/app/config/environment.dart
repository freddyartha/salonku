import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Environment { development, production }

class EnvironmentConfig {
  static Environment? _current;

  // Initialize environment configuration
  static Future<void> init() async {
    await dotenv.load(fileName: 'conf/.env');
    _current = dotenv.env['ENV'] == "dev"
        ? Environment.development
        : Environment.production;
  }

  static Environment get current => _current ?? Environment.development;

  static bool get isDevelopment => current == Environment.development;
  static bool get isProduction => current == Environment.production;

  // API Configuration
  static String get hostUrl => dotenv.env['BASE_URL'] ?? '';

  static bool get enableLogging => _current == Environment.development;
  static bool get enableDebugMode => _current == Environment.development;

  // Timeouts (in seconds)
  static Duration get connectTimeout =>
      Duration(seconds: int.parse(dotenv.env['CONNECT_TIMEOUT'] ?? '30'));
  static Duration get receiveTimeout =>
      Duration(seconds: int.parse(dotenv.env['RECEIVE_TIMEOUT'] ?? '30'));
  static Duration get sendTimeout =>
      Duration(seconds: int.parse(dotenv.env['SEND_TIMEOUT'] ?? '30'));
}

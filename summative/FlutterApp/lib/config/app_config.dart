import 'package:flutter/foundation.dart' show kIsWeb;

class AppConfig {
  // API endpoint configuration
  static String get apiBaseUrl {
    if (kIsWeb) {
      // Use localhost for web builds
      return 'http://localhost:10000';
    } else {
      // Use 10.0.2.2 for Android emulator
      return 'http://10.0.2.2:10000';
    }
  }

  // App version
  static const String appVersion = '1.0.0';

  // Other configuration settings can be added here
}

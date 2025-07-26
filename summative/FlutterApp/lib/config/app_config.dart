import 'package:flutter/foundation.dart' show kIsWeb;

class AppConfig {
  // API endpoint configuration
  static String get apiBaseUrl {
    // Replace with your actual Render URL
    return 'https://linearregression-su6l.onrender.com';
    
    // For local development, uncomment below:
    // if (kIsWeb) {
    //   return 'http://localhost:8000';
    // } else {
    //   return 'http://10.0.2.2:8000';
    // }
  }

  // App version
  static const String appVersion = '1.0.0';

  // Other configuration settings can be added here
}

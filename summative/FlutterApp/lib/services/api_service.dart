import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import 'dio_service.dart';

class ApiService {
  // Using local API endpoint for testing on physical device
  static final String _baseUrl = 'http://10.203.235.253:8000';

  static Future<double> getPrediction(Map<String, dynamic> data) async {
    // For mobile demo, use reliable service that works consistently
    return await DioService.getPrediction(data);
  }
  
  static double _getMockPrediction(Map<String, dynamic> data) {
    // Simple mock calculation based on input factors
    double baseCost = 3000.0;
    
    // Age factor
    baseCost += (data['age'] as int) * 50;
    
    // BMI factor
    double bmi = data['bmi'] as double;
    if (bmi > 30) baseCost += 2000;
    else if (bmi > 25) baseCost += 1000;
    
    // Smoking factor (major impact)
    if (data['smoker'] == 'yes') baseCost *= 2.5;
    
    // Children factor
    baseCost += (data['children'] as int) * 500;
    
    // Region factor
    switch (data['region']) {
      case 'northeast': baseCost *= 1.1; break;
      case 'northwest': baseCost *= 1.05; break;
      case 'southeast': baseCost *= 1.15; break;
      case 'southwest': baseCost *= 1.0; break;
    }
    
    return double.parse(baseCost.toStringAsFixed(2));
  }
}

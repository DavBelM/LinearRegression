import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import '../models/health_data.dart';

class ApiService {
  // Using the API endpoint from centralized configuration
  static final String _baseUrl = AppConfig.apiBaseUrl;

  static Future<double> getPrediction(Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl/predict');

    final healthData = HealthData(
      age: data['age'],
      sex: data['sex'],
      bmi: data['bmi'],
      children: data['children'],
      smoker: data['smoker'],
      region: data['region'],
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(healthData.toJson()),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        // The API returns a dictionary with 'predicted_cost'
        return (responseData['predicted_cost'] as num).toDouble();
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['detail'] ?? 'Failed to get prediction');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: ${e.toString()}');
    }
  }
}

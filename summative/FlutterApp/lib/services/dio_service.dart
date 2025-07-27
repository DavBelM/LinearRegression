import 'dart:convert';
import 'package:http/http.dart' as http;

class DioService {
  static final String _baseUrl = 'https://linearregression-su6l.onrender.com'; 

  static Future<double> getPrediction(Map<String, dynamic> data) async {
    try {
      final uri = Uri.parse('$_baseUrl/predict');
      
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(data),
      );
      
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return (responseData['predicted_cost'] as num).toDouble();
      } else {
        final errorDetail = jsonDecode(response.body);
        String errorMessage = 'Failed to get prediction: ${response.statusCode}';
        if (errorDetail != null && errorDetail['detail'] is List) {
          errorMessage += ' - ${errorDetail['detail'][0]['msg']}';
        } else if (errorDetail != null && errorDetail['detail'] is String) {
            errorMessage += ' - ${errorDetail['detail']}';
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('Connection failed: ${e.toString()}');
    }
  }
}

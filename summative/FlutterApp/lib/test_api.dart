import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  final url = Uri.parse('https://linearregression-su6l.onrender.com/predict');
  
  final data = {
    'age': 25,
    'sex': 'female',
    'bmi': 22.5,
    'children': 0,
    'smoker': 'no',
    'region': 'northeast',
  };
  
  try {
    print('Making request to: $url');
    print('Data: ${jsonEncode(data)}');
    
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    ).timeout(const Duration(seconds: 60));
    
    print('Status: ${response.statusCode}');
    print('Response: ${response.body}');
    
  } catch (e) {
    print('Error: $e');
  }
}
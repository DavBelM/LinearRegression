import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import 'dio_service.dart';

class ApiService {
  static Future<double> getPrediction(Map<String, dynamic> data) async {
    return await DioService.getPrediction(data);
  }
}

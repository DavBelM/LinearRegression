import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../config/app_theme.dart';

class ResultsScreen extends StatelessWidget {
  final Map<String, dynamic> predictionData;

  const ResultsScreen({Key? key, required this.predictionData}) : super(key: key);

  // Helper to create styled list tiles for user info
  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primaryColor.shade300, size: 20),
          const SizedBox(width: 16),
          Text('$label:', style: AppTheme.bodyStyle.copyWith(fontWeight: FontWeight.bold)),
          const Spacer(),
          Text(value, style: AppTheme.bodyStyle),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedPrediction = NumberFormat.currency(
      locale: 'en_US', 
      symbol: '\$'
    ).format(predictionData['prediction']);

    final inputData = predictionData['input_data'] as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediction Results'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppTheme.textColor),
        titleTextStyle: AppTheme.subheadingStyle.copyWith(fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Result Card with Gradient
              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppTheme.primaryColor.shade300, AppTheme.primaryColor.shade500],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Predicted Health Insurance Cost',
                      style: AppTheme.subheadingStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      formattedPrediction,
                      style: AppTheme.headingStyle.copyWith(fontSize: 48, color: Colors.white, fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'per year',
                      style: AppTheme.bodyStyle.copyWith(color: Colors.white70, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Input Summary Card
              const Text('Your Information', style: AppTheme.headingStyle),
              const SizedBox(height: 16),
              Card(
                elevation: 2,
                shadowColor: Colors.grey.shade50,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      _buildInfoRow(context, Icons.cake_outlined, 'Age', '${inputData['age']} years'),
                      _buildInfoRow(context, Icons.person_outline, 'Sex', inputData['sex']),
                      _buildInfoRow(context, Icons.monitor_weight_outlined, 'BMI', inputData['bmi'].toString()),
                      _buildInfoRow(context, Icons.child_care_outlined, 'Children', inputData['children'].toString()),
                      _buildInfoRow(context, Icons.smoking_rooms_outlined, 'Smoker', inputData['smoker']),
                      _buildInfoRow(context, Icons.public_outlined, 'Region', inputData['region']),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              // Info Box
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What affects your health insurance cost?',
                      style: AppTheme.subheadingStyle.copyWith(color: AppTheme.primaryColor.shade800, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '• Age: Costs typically increase with age\n'
                      '• BMI: Higher BMI often leads to higher costs\n'
                      '• Smoking: Smokers pay significantly more\n'
                      '• Children: More dependents can affect costs\n'
                      '• Region: Costs vary by geographical location',
                      style: AppTheme.bodyStyle,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Back button
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Make Another Prediction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  String _capitalize(String text) {
    return text.substring(0, 1).toUpperCase() + text.substring(1);
  }
}
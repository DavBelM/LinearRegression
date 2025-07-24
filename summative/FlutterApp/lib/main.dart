import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/prediction_screen.dart';
import 'screens/results_screen.dart';
import 'config/app_theme.dart';

void main() {
  runApp(const HealthCostApp());
}

class HealthCostApp extends StatelessWidget {
  const HealthCostApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Cost Predictor',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/results') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return ResultsScreen(predictionData: args);
            },
          );
        }
        // Handle other routes if necessary
        return null;
      },
      routes: {
        '/': (context) => const HomeScreen(),
        '/predict': (context) => const PredictionScreen(),
      },
    );
  }
}

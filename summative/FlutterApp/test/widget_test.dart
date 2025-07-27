// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:health_cost_predictor/main.dart';

void main() {
  testWidgets('Health Cost App loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const HealthCostApp());
    await tester.pumpAndSettle();

    // Verify that the app loads with the home screen
    expect(find.text('Health Cost Prediction'), findsOneWidget);
    expect(find.byIcon(Icons.health_and_safety_rounded), findsOneWidget);
  });
}

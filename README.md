# Health Cost Prediction Model Deployment

## Mission & Problem Statement

This project demonstrates the end-to-end deployment of a machine learning model for predicting individual health-related costs. While utilizing a U.S. insurance dataset for development, the core mission is to simulate how such predictive analytics can be adapted for health education and financial planning in an African context, such as Rwanda, raising awareness about the impact of personal health factors on medical expenses.

## Publicly Available API Endpoint

Our FastAPI application is deployed and publicly accessible, serving predictions from the trained model:

- **Base URL:** `https://linearregression-su6l.onrender.com`
- **Swagger UI Documentation:** `https://linearregression-su6l.onrender.com/docs`

You can test the `/predict` endpoint directly via the Swagger UI.

## Video Demonstration

A comprehensive video demonstration of the entire project pipeline, including the mobile app, API, and model explanation, is available on YouTube:

**YouTube Demo Link:** `https://youtu.be/yuq15_NabBU`

## How to Run the Mobile App (FlutterApp)

To set up and run the Flutter mobile application locally, follow these steps:

### Prerequisites

- Ensure you have Flutter SDK installed and configured. You can check your setup by running `flutter doctor` in your terminal.
- Have a Flutter-compatible IDE (like VS Code with the Flutter extension or Android Studio).
- An Android emulator (e.g., via Android Studio AVD Manager) or an iOS simulator (Xcode on macOS) or a Chrome browser for web emulator.

### Setup Instructions

1. **Navigate to the Flutter Project**
   
   Open your terminal or command prompt and navigate to the `FlutterApp` directory within your repository:
   
   ```bash
   cd linear_regression_model/summative/FlutterApp
   ```

2. **Get Dependencies**
   
   Fetch all the required Flutter and Dart packages:
   
   ```bash
   flutter pub get
   ```

3. **Configure API Base URL**
   
   Open the `lib/services/dio_service.dart` file in your Flutter project. Ensure the `_baseUrl` variable is set to your deployed FastAPI URL:
   
   - For local testing with an Android emulator, use `http://10.0.2.2:8000`
   - For iOS simulator or desktop, use `http://localhost:8000`
   - For the final submission, it should point to your Render URL:
   
   ```dart
   // In lib/services/dio_service.dart
   static final String _baseUrl = 'https://linearregression-su6l.onrender.com';
   ```

4. **Run the App**
   
   Connect your mobile device, start an emulator, or select 'Chrome (web)' as your target device in your IDE. Then, run the application:
   
   ```bash
   flutter run
   ```
   
   If running in VS Code, you can also click 'Run' -> 'Start Debugging' or press `F5`.

The app should launch, and you can then interact with it to make predictions by inputting health data and tapping the 'Predict' button.

## Project Structure

```
linear_regression_model/summative/
├── FlutterApp/
│   ├── lib/
│   │   └── services/
│   │       └── dio_service.dart
│   └── ...
└── ...
```

## Technologies Used

- **Machine Learning:** Linear Regression Model
- **Backend API:** FastAPI
- **Mobile App:** Flutter
- **Deployment:** Render
- **Documentation:** Swagger UI

## Getting Started

1. Clone the repository
2. Follow the mobile app setup instructions above
3. Test the API endpoints using the Swagger UI
4. Watch the video demonstration for a complete walkup

## Support

For questions or issues, please refer to the video demonstration or check the API documentation at the Swagger UI endpoint.

# Health Cost Predictor Flutter App

This Flutter application predicts health insurance costs based on personal health factors. It's part of a larger project that includes a machine learning model and FastAPI backend.

## Features

- User-friendly interface for entering health data
- Real-time validation of input data
- API integration with the prediction backend
- Detailed results display with cost breakdown
- Educational information about health cost factors

## Getting Started

### Prerequisites

- Flutter SDK (2.17.0 or higher)
- Dart SDK
- Android Studio or Xcode for emulator/simulator
- An active internet connection

### Installation

1. Clone the repository
2. Navigate to the Flutter app directory:
   ```
   cd summative/FlutterApp
   ```
3. Install dependencies:
   ```
   flutter pub get
   ```
4. Update the API endpoint in `lib/config/app_config.dart` with your deployed API URL

### Running the App

Run the app on an emulator or physical device:

```
flutter run
```

## Project Structure

- `lib/main.dart` - Entry point of the application
- `lib/screens/` - UI screens
  - `home_screen.dart` - Welcome screen with project information
  - `prediction_screen.dart` - Form for entering health data
  - `results_screen.dart` - Displays prediction results
- `lib/services/` - API and other services
  - `api_service.dart` - Handles API calls to the backend
- `lib/models/` - Data models
  - `health_data.dart` - Model for health data
- `lib/widgets/` - Reusable UI components
- `lib/config/` - App configuration
  - `app_config.dart` - API endpoint and other settings
  - `app_theme.dart` - App styling

## API Integration

The app connects to a FastAPI backend that hosts the trained machine learning model. Make sure to update the API endpoint in `lib/config/app_config.dart` with your deployed API URL.

## Demo

For a video demonstration of the app, visit: [YouTube Demo Link](https://youtu.be/your-video-id)
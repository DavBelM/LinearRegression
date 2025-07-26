# Health Cost Prediction Project

## Description of Mission and Problem
This project develops a health cost prediction system for an African context simulation, aiming to raise awareness about how personal health factors influence medical costs and promote data-driven health planning.

## Project Structure

The project is organized into three main components:

### 1. Linear Regression Model
- Located in `/summative/linear_regression/`
- Contains a Jupyter notebook (`multivariate.ipynb`) that:
  - Loads and analyzes the insurance dataset
  - Performs data visualization and feature engineering
  - Builds and compares linear regression, decision tree, and random forest models
  - Saves the best-performing model for use in the API

### 2. FastAPI Backend
- Located in `/summative/API/`
- Provides a REST API endpoint for making predictions
- Implements data validation using Pydantic
- Includes CORS middleware for cross-origin requests
- Deployed on Render (see API endpoint below)

### 3. Flutter Mobile App
- Located in `/summative/FlutterApp/`
- Provides a user-friendly interface for entering health data
- Makes API calls to get predictions
- Displays results to the user

## API Endpoint
[https://linearregression-su6l.onrender.com/docs](https://linearregression-su6l.onrender.com/docs)

## Video Demo
[YouTube Demo Link](https://youtu.be/your-video-id)

## Running the Flutter App

### Prerequisites
- Flutter SDK installed
- Android Studio or Xcode for emulator/simulator
- An active internet connection

### Steps to Run
1. Clone this repository
2. Navigate to the Flutter app directory: `cd summative/FlutterApp`
3. Install dependencies: `flutter pub get`
4. Update the API endpoint in `lib/services/api_service.dart`
5. Run the app: `flutter run`
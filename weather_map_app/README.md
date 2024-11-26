# weather_map_app

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Weather App Development Documentation
1. API Chosen and Its Purpose
API Chosen
The OpenWeatherMap API was chosen for this project.

Purpose
The purpose of the OpenWeatherMap API is to provide current weather data and forecasts for any location worldwide. It allows developers to access weather information such as temperature, humidity, wind speed, and weather conditions (e.g., clear, cloudy, rain) in a structured format (JSON). This API is essential for building a weather application, enabling users to obtain real-time weather data based on their input.

2. Screens Created and Their Functionalities
Home Screen
Functionality:
Users can enter a city name to retrieve current weather data.
The screen features two buttons: "Get Current Weather" and "Get Forecast".
Displays the current temperature and weather condition after fetching data.
Provides navigation to a detailed weather screen for more information.
Includes a settings button to navigate to the settings screen.
Weather Details Screen
Functionality:
Displays detailed weather information such as temperature, humidity, wind speed, and a description of the weather.
Provides users with a comprehensive view of the weather for the selected city.
Forecast Screen
Functionality:
Displays a 7-day weather forecast for the specified city.
Users can view daily temperature highs and lows, as well as weather conditions for each day.
Settings Screen
Functionality:
Allows users to configure app settings (e.g., temperature units, notification preferences).
Provides options for users to customize their experience.
3. Challenges Faced During Development and Resolutions
Challenge 1: API Integration
Issue: Difficulty in integrating the OpenWeatherMap API and handling the response data.
Resolution: I carefully read the API documentation to understand the required parameters and response structure. I used the http package in Flutter to make GET requests and parsed the JSON response to extract relevant weather data.
Challenge 2: State Management
Issue: Managing the loading state and displaying error messages appropriately.
Resolution: I utilized Flutter’s setState method to manage the loading state and error messages. This approach allowed me to update the UI dynamically based on the API response.
Challenge 3: UI Design and Responsiveness
Issue: Ensuring the UI was responsive and visually appealing across different device sizes.
Resolution: I used Flutter's layout widgets like Column, Row, and Container with appropriate padding and margins to create a responsive design. Additionally, I tested the app on various screen sizes using an emulator.
4. Submission Format
This document serves as the required documentation for the Weather App project.

GitHub Repository
Link to GitHub Repository

Demo Video
Link to Demo Video

File Naming
The document and submission files are named as follows:

your_email@example.com_WeatherApp
Conclusion
This documentation outlines the development process of the Weather App, detailing the API used, the functionalities of each screen, challenges faced during development, and their resolutions. The app is fully functional and provides users with real-time weather information and forecasts.
// ignore_for_file: unused_import, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'weather_details_screen.dart';
import 'settings_screen.dart';
import 'forecast_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(), // Start with HomeScreen
      routes: {
        '/weatherDetails': (context) => WeatherDetailsScreen(
            weatherData: const {}), // Pass dummy data for now
        '/settings': (context) => SettingsScreen(),
        '/forecast': (context) =>
            ForecastScreen(city: ''), // Assume you have a ForecastScreen
      },
    );
  }
}

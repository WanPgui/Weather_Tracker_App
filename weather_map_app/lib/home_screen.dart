import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants.dart'; // Ensure this file contains your API key and base URL
import 'weather_details_screen.dart'; // Import the WeatherDetailsScreen
import 'settings_screen.dart'; // Import the SettingsScreen
import 'forecast_screen.dart'; // Import the ForecastScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic>? weatherData;
  bool isLoading = false; // To track loading state
  String errorMessage = ''; // To track error messages

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Enter City Name',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final cityName = _controller.text.trim();
                  if (cityName.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter a city name')),
                    );
                    return;
                  }

                  setState(() {
                    isLoading = true; // Start loading
                    errorMessage = ''; // Clear previous error messages
                  });

                  // Fetch current weather data
                  final response = await http.get(
                    Uri.parse(
                      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric',
                    ),
                  );

                  if (response.statusCode == 200) {
                    setState(() {
                      weatherData = json.decode(response.body);
                      isLoading = false; // Data loaded successfully
                    });
                  } else {
                    // Log the response body for debugging
                    print('Error: ${response.statusCode} - ${response.body}');
                    setState(() {
                      errorMessage = 'Failed to load weather data';
                      isLoading = false; // Set loading to false on error
                      weatherData = null; // Reset weatherData on error
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: Colors.orange,
                ),
                child: const Text('Get Current Weather'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final cityName = _controller.text.trim();
                  if (cityName.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter a city name')),
                    );
                    return;
                  }

                  // Navigate to ForecastScreen with the entered city name
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForecastScreen(city: cityName),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: Colors.green,
                ),
                child: const Text('Get Forecast'),
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const CircularProgressIndicator() // Show loading indicator
                  : errorMessage.isNotEmpty
                      ? Center(child: Text(errorMessage)) // Show error message
                      : Container(
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: weatherData != null
                              ? Column(
                                  children: [
                                    Text(
                                      'Temperature: ${weatherData!['main']?['temp']?.toStringAsFixed(1) ?? 'N/A'}°C',
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Condition: ${weatherData!['weather']?.isNotEmpty == true ? weatherData!['weather'][0]['description'] : 'N/A'}',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Navigate to WeatherDetailsScreen
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                WeatherDetailsScreen(
                                                    weatherData: weatherData!),
                                          ),
                                        );
                                      },
                                      child:
                                          const Text('View Detailed Weather'),
                                    ),
                                  ],
                                )
                              : const Text(
                                  'Please enter a city name to get the weather.',
                                  style: TextStyle(fontSize: 18),
                                ),
                        ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to SettingsScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                    child: const Text('Settings'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

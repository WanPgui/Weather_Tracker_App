import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants.dart';

class ForecastScreen extends StatefulWidget {
  final String city;

  const ForecastScreen({super.key, required this.city});

  @override
  _ForecastScreenState createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  late Map<String, dynamic> weatherData;
  bool isLoading = true; // To track loading state
  String errorMessage = ''; // To track error messages

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    try {
      final response = await http.get(
        Uri.parse(
            '$forecastBaseUrl?q=${widget.city}&appid=$apiKey&units=metric'), // Use the forecast base URL
      );

      if (response.statusCode == 200) {
        setState(() {
          weatherData = json.decode(response.body);
          isLoading = false; // Data loaded successfully
        });
      } else {
        setState(() {
          errorMessage =
              'Failed to load weather data: ${response.reasonPhrase}';
          isLoading = false; // Set loading to false on error
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred: $e';
        isLoading = false; // Set loading to false on exception
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forecast'),
        backgroundColor: Colors.blueAccent,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Show loading indicator
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage)) // Show error message
              : Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color.fromRGBO(179, 229, 252, 1), Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tomorrow's Forecast Card
                        _buildForecastCard(
                          day: 'Tomorrow',
                          temperature:
                              '${weatherData['list'][1]['main']['temp'].toStringAsFixed(1)}°C', // Get temp for tomorrow
                          condition: weatherData['list'][1]['weather'][0]
                              ['description'],
                          icon: weatherData['list'][1]['weather'][0]['icon'],
                        ),
                        const SizedBox(height: 20),
                        // Day After Tomorrow's Forecast Card
                        _buildForecastCard(
                          day: 'Day After Tomorrow',
                          temperature:
                              '${weatherData['list'][2]['main']['temp'].toStringAsFixed(1)}°C', // Get temp for day after tomorrow
                          condition: weatherData['list'][2]['weather'][0]
                              ['description'],
                          icon: weatherData['list'][2]['weather'][0]['icon'],
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildForecastCard({
    required String day,
    required String temperature,
    required String condition,
    required String icon,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  day,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  condition,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
            Image.network(
              'http://openweathermap.org/img/wn/$icon@2x.png',
              height: 50,
              width: 50,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error,
                    size: 50); // Fallback icon on error
              },
            ),
            Text(
              temperature,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class WeatherDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const WeatherDetailsScreen({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    // Determine the background color based on the weather condition
    Color backgroundColor;
    String weatherCondition =
        (weatherData['weather'] != null && weatherData['weather'].isNotEmpty)
            ? weatherData['weather'][0]['main'] ?? 'clear'
            : 'clear'; // Default to 'clear' if not available

    switch (weatherCondition.toLowerCase()) {
      case 'clear':
        backgroundColor = const Color.fromRGBO(100, 181, 246, 1);
        break;
      case 'clouds':
        backgroundColor = const Color.fromRGBO(189, 189, 189, 1);
        break;
      case 'rain':
        backgroundColor = const Color.fromRGBO(84, 110, 122, 1);
        break;
      case 'snow':
        backgroundColor = Colors.white;
        break;
      default:
        backgroundColor = const Color.fromRGBO(100, 181, 246, 1);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Details'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [backgroundColor, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Weather Icon
                if (weatherData['weather'] != null &&
                    weatherData['weather'].isNotEmpty)
                  Image.network(
                    'http://openweathermap.org/img/wn/${weatherData['weather'][0]['icon']}@2x.png',
                    height: 100,
                    width: 100,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error,
                          size: 100); // Fallback icon on error
                    },
                  )
                else
                  const Icon(Icons.error,
                      size:
                          100), // Fallback icon if weather data is not available

                const SizedBox(height: 20),

                // Temperature Card
                _buildWeatherCard(
                  title: 'Temperature',
                  value: _getTemperatureValue(weatherData),
                  icon: Icons.thermostat,
                ),

                const SizedBox(height: 20),

                // Humidity Card
                _buildWeatherCard(
                  title: 'Humidity',
                  value: '${weatherData['main']?['humidity'] ?? 'N/A'} %',
                  icon: Icons.water_drop,
                ),

                const SizedBox(height: 20),

                // Wind Speed Card
                _buildWeatherCard(
                  title: 'Wind Speed',
                  value: '${weatherData['wind']?['speed'] ?? 'N/A'} m/s',
                  icon: Icons.air,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getTemperatureValue(Map<String, dynamic> weatherData) {
    if (weatherData['main'] != null && weatherData['main']['temp'] != null) {
      // Convert from Kelvin to Celsius
      double tempInCelsius = weatherData['main']['temp'] - 273.15;
      return '${tempInCelsius.toStringAsFixed(1)} °C';
    } else {
      return 'N/A'; // Return 'N/A' if temperature data is not available
    }
  }

  Widget _buildWeatherCard({
    required String title,
    required String value,
    required IconData icon,
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
            Icon(icon, size: 40, color: Colors.blueAccent),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

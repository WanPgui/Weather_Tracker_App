import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool useCelsius = true;
  bool useCurrentLocation = true;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      useCelsius = prefs.getBool('useCelsius') ?? true;
      useCurrentLocation = prefs.getBool('useCurrentLocation') ?? true;
      isLoading = false;
    });
  }

  Future<void> _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('useCelsius', useCelsius);
    await prefs.setBool('useCurrentLocation', useCurrentLocation);
    // You can add more settings to save here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.blueAccent,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromRGBO(144, 202, 249, 1), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Preferences',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    _buildSettingsCard(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSettingsCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Use Celsius'),
              secondary: const Icon(Icons.thermostat),
              value: useCelsius,
              onChanged: (value) {
                setState(() {
                  useCelsius = value;
                });
                _saveSettings(); // Save settings when changed
              },
            ),
            SwitchListTile(
              title: const Text('Use Current Location'),
              secondary: const Icon(Icons.location_on),
              value: useCurrentLocation,
              onChanged: (value) {
                setState(() {
                  useCurrentLocation = value;
                });
                _saveSettings(); // Save settings when changed
              },
            ),
            // Additional Settings Options
            SwitchListTile(
              title: const Text('Enable Notifications'),
              secondary: const Icon(Icons.notifications),
              value: true, // Placeholder for notifications
              onChanged: (value) {
                // Handle notifications toggle
              },
            ),
            SwitchListTile(
              title: const Text('Dark Mode'),
              secondary: const Icon(Icons.dark_mode),
              value: false, // Placeholder for dark mode
              onChanged: (value) {
                // Handle dark mode toggle
              },
            ),
          ],
        ),
      ),
    );
  }
}

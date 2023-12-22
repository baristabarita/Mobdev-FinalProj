import 'package:flutter/material.dart';
import 'package:weather_weather/screens/dashboard_screen.dart';
import 'package:weather_weather/screens/profile_screen.dart';
import 'package:weather_weather/widgets/BottomNavbar.dart';

class ForecastScreen extends StatefulWidget {
  static String routeName = "/forecast";
  const ForecastScreen({Key? key}) : super(key: key);

  @override
  State<ForecastScreen> createState() => _ForecastState();
}

class _ForecastState extends State<ForecastScreen> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'This is the Forecast Screen',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // Handle navigation or any other logic based on the selected index
           if (_currentIndex == 0) {
            Navigator.pushNamed(context, DashboardScreen.routeName);
          } else if(_currentIndex == 2){
            Navigator.pushNamed(context, ProfileScreen.routeName);
          }
        },
      ),
    );
  }
}
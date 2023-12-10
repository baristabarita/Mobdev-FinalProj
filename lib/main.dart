import 'package:flutter/material.dart';
import 'package:weather_weather/screens/login_screen.dart';
import 'package:weather_weather/screens/registration_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: { 
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegistrationScreen(),
        },
    );
  }
}

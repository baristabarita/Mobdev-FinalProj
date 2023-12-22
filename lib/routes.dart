import 'package:flutter/widgets.dart';
import 'package:weather_weather/screens/login_screen.dart';
import 'package:weather_weather/screens/registration_screen.dart';
import 'package:weather_weather/screens/dashboard_screen.dart';
import 'package:weather_weather/screens/forecast_screen.dart';
import 'package:weather_weather/screens/profile_screen.dart';

final Map<String, WidgetBuilder> routes = {
  RegistrationScreen.routeName: (context) => RegistrationScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  DashboardScreen.routeName: (context) => DashboardScreen(),
  ForecastScreen.routeName: (context) => ForecastScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(), 
};
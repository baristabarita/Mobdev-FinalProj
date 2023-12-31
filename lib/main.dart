import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weather_weather/firebase_options.dart';
import 'package:weather_weather/routes.dart';
import 'package:weather_weather/screens/dashboard_screen.dart';
import 'package:weather_weather/screens/login_screen.dart';
import 'package:weather_weather/services/StorageServices.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  StorageService storageService = StorageService();

  var item = await storageService.readData("uid");
  
  if (item != null) {
    runApp(MaterialApp(
      initialRoute: DashboardScreen.routeName,
      routes: routes,
    ));
  }else{
    runApp(MaterialApp(
      initialRoute: LoginScreen.routeName,
      routes: routes,
    ));
  }
}

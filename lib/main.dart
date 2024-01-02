import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weather_weather/firebase_options.dart';
import 'package:weather_weather/routes.dart';
import 'package:weather_weather/screens/login_screen.dart';
import 'package:weather_weather/screens/dashboard_screen.dart';
import 'package:weather_weather/services/StorageServices.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_weather/bloc/weather_bloc_bloc.dart';
import 'package:geolocator/geolocator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Call the mainRouting function instead of runApp
  await mainRouting();
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _determinePosition(),
        builder: (context, snap) {
          if (snap.hasData) {
            return BlocProvider<WeatherBlocBloc>(
              create: (context) =>
                  WeatherBlocBloc()..add(FetchWeather(snap.data as Position)),
              child: const DashboardScreen(),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}

Future<void> mainRouting() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  StorageService storageService = StorageService();
  var item = await storageService.readData("uid");

  runApp(MaterialApp(
    // Adjust the initialRoute based on the presence of "uid"
    initialRoute: item != null ? DashboardScreen.routeName : LoginScreen.routeName,
    routes: routes,
  ));
}


Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied.');
  }

  return await Geolocator.getCurrentPosition();
}

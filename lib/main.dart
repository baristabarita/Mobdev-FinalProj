import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weather_weather/firebase_options.dart';
import 'package:weather_weather/routes.dart';
import 'package:weather_weather/screens/dashboard_screen.dart';
import 'package:weather_weather/screens/login_screen.dart';
import 'package:weather_weather/services/StorageServices.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_weather/bloc/weather_bloc_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Position? _position;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _determinePosition().then((position) {
      setState(() {
        _position = position;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBlocBloc>(
          create: (context) {
            final bloc = WeatherBlocBloc();
            if (_position != null) {
              bloc.add(FetchWeather(_position!));
            }
            return bloc;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<User?>(
          stream: _auth.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.hasData && _position != null) {
              return const DashboardScreen();
            } else {
              return const LoginScreen();
            }
          },
        ),
        routes: routes,
      ),
    );
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
}
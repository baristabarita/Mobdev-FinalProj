import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_weather/bloc/weather_bloc_bloc.dart';
import 'package:weather_weather/screens/dashboard_screen.dart';
import 'package:weather_weather/screens/profile_screen.dart';
import 'package:weather_weather/widgets/BottomNavbar.dart';
import 'package:intl/intl.dart';
import 'package:weather_weather/widgets/ForecastChart.dart'; // Import your ForecastChartWidget
import 'package:weather_weather/services/ForecastServices.dart'; // Import your ForecastService
import 'package:weather_weather/models/forecast.dart';

class ForecastScreen extends StatefulWidget {
  static String routeName = "/forecast";
  const ForecastScreen({Key? key}) : super(key: key);

  @override
  State<ForecastScreen> createState() => _ForecastState();
}

class _ForecastState extends State<ForecastScreen> {
  int _currentIndex = 1;
  final ForecastService forecastService = ForecastService();
  Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset('assets/1.png', scale: 4);
      case >= 300 && < 400:
        return Image.asset('assets/2.png', scale: 4);
      case >= 500 && < 600:
        return Image.asset('assets/3.png', scale: 4);
      case >= 600 && < 700:
        return Image.asset('assets/4.png', scale: 4);
      case >= 700 && < 800:
        return Image.asset('assets/5.png', scale: 4);
      case == 800:
        return Image.asset('assets/6.png', scale: 4);
      case > 800 && <= 804:
        return Image.asset('assets/7.png', scale: 4);
      default:
        return Image.asset('assets/7.png', scale: 4);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4A91FF),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white, // Change this to your desired color
        ),
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(45, 1.2 * kToolbarHeight, 45, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFF47BFDF)),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFF47BFDF)),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 600,
                  decoration: const BoxDecoration(color: Color(0xFF47BFDF)),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                builder: (context, state) {
                  if (state is WeatherBlocSuccess) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Forecast Screen',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  getWeatherIcon(
                                      state.weather.weatherConditionCode!),
                                  Column(),
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '📍 ${state.weather.areaName}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '${state.weather.temperature!.celsius!.round()}°C',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        DateFormat('EEEEE')
                                            .add_jm()
                                            .format(state.weather.date!),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 3.0),
                            child: Divider(
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                Image.asset(
                                  'assets/8.png',
                                  scale: 9,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Cloudiness',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      "${state.weather.cloudiness}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                )
                              ]),
                              Row(children: [
                                Image.asset(
                                  'assets/15.png',
                                  scale: 9,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Humidity',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      "${state.weather.humidity}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 40)
                              ])
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                Image.asset(
                                  'assets/17.png',
                                  scale: 9,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Wind Speed',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      "${state.weather.windSpeed}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                )
                              ]),
                              Row(children: [
                                Image.asset(
                                  'assets/16.png',
                                  scale: 9,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Pressure',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      "${state.weather.pressure}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                )
                              ])
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 3.0),
                            child: Divider(
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center, // Center the content
                            child: Text(
                              "5 Day Forecast by Precipitation Level",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          FutureBuilder<List<Forecast>>(
                            future: forecastService.fetchFiveDayForecast(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (snapshot.hasData) {
                                  return Container(
                                    // Solution 1: Wrap with Container
                                    height: 300, // Specify the height
                                    width: double
                                        .infinity, // Take as much width as possible
                                    child: ForecastChartWidget(
                                        forecastData: snapshot.data!),
                                  );
                                } else {
                                  return Text('No forecast data available');
                                }
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
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
          } else if (_currentIndex == 2) {
            Navigator.pushNamed(context, ProfileScreen.routeName);
          }
        },
      ),
    );
  }
}

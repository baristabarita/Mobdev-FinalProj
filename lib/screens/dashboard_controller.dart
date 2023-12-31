import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:weather_weather/models/current_weather_data.dart';
import 'package:weather_weather/services/weather_service.dart';

class DashboardController extends GetxController {
  String? city;
  String? searchText;

  CurrentWeatherData currentWeatherData = CurrentWeatherData();

  DashboardController({@required this.city});

  @override
  void onInit() {
    initState();
    super.onInit();
  }

  void initState() {
    WeatherService(city: '$city').getCurrentWeatherData(
        onSuccess: (data) {
          currentWeatherData = data;
          update();
        },
        beforeSend: () {},
        onError: (error) {});
  }
}

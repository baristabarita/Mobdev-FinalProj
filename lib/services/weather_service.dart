import 'package:weather_weather/api/api_repository.dart';
import 'package:weather_weather/models/current_weather_data.dart';
import 'package:flutter/foundation.dart';

class WeatherService {
  final String? city;

  String baseUrl = 'https://api.openweathermap.org/data/2.5';
  String apiKey = 'appid=6ab4adb855c142fbb59173526218f402';

  WeatherService({@required this.city});

  void getCurrentWeatherData({
    required Function() beforeSend,
    required Function(CurrentWeatherData currentWeatherData) onSuccess,
    required Function(dynamic error) onError,
  }) {
    final url = '$baseUrl/weather?q=$city&lang=en&$apiKey';
    //print(url);
    ApiRepository(url: '$url', payload: null).get(
        beforeSend: () => {
              if (beforeSend != null)
                {
                  beforeSend(),
                },
            },
        onSuccess: (data) => {
              onSuccess(CurrentWeatherData.fromJson(data)),
            },
        onError: (error) => {
              if (onError != null)
                {
                  print(error),
                  onError(error),
                }
            });
  }

  // void getFiveDaysThreeHoursForcastData({
  //   Function() beforSend,
  //   Function(List<FiveDayData> fiveDayData) onSuccess,
  //   Function(dynamic error) onError,
  // }) {
  //   final url = '$baseUrl/forecast?q=$city&lang=en&$apiKey';
  //   print(url);
  //   ApiRepository(url: '$url', payload: null).get(
  //       beforeSend: () => {},
  //       onSuccess: (data) => {
  //             onSuccess((data['list'] as List)
  //                     ?.map((t) => FiveDayData.fromJson(t))
  //                     ?.toList() ??
  //                 List.empty()),
  //           },
  //       onError: (error) => {
  //             print(error),
  //             onError(error),
  //           });
  // }
}

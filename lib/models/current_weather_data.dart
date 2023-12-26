import 'package:weather_weather/models/clouds.dart';
import 'package:weather_weather/models/coord.dart';
import 'package:weather_weather/models/main_weather.dart';
import 'package:weather_weather/models/sys.dart';
import 'package:weather_weather/models/weather.dart';
import 'package:weather_weather/models/wind.dart';

class CurrentWeatherData {
  final Coord coord;
  final List<Weather> weather;
  final String base;
  final MainWeather main;
  final int visibility;
  final Wind wind;
  final Clouds clouds;
  final int dt;
  final Sys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  CurrentWeatherData(
      {required this.coord,
      required this.weather,
      required this.base,
      required this.main,
      required this.visibility,
      required this.wind,
      required this.clouds,
      required this.dt,
      required this.sys,
      required this.timezone,
      required this.id,
      required this.name,
      required this.cod});

  factory CurrentWeatherData.fromJson(dynamic json) {
    return CurrentWeatherData(
        coord: Coord.fromJson(json['coord']),
        weather: (json['weather'] as List)
                ?.map((w) => Weather.fromJson(w))
                ?.toList() ??
            List.empty(),
        base: json['base'],
        main: MainWeather.fromJson(json['main']),
        visibility: json['visibility'],
        wind: Wind.fromJson(json['wind']),
        clouds: Clouds.fromJson(json['clouds']),
        dt: json['dt'],
        sys: Sys.fromJson(json['sys']),
        timezone: json['timezone'],
        id: json['id'],
        name: json['name'],
        cod: json['cod']);
  }
}

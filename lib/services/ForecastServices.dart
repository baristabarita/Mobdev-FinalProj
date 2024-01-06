import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_weather/models/forecast.dart';

class ForecastService {
  final String baseUrl =
      'https://api.openweathermap.org/data/2.5/forecast?lat=44.34&lon=10.99&appid=6ab4adb855c142fbb59173526218f402';

  Future<List<Forecast>> fetchFiveDayForecast() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      // Decode the JSON response into a Map
      Map<String, dynamic> data = jsonDecode(response.body);

      // Extract the 'list' array which contains the forecast data
      List<dynamic> forecastList = data['list'] as List;

      // Parse each forecast entry and return a list of Forecast objects
      return forecastList
          .map((json) => Forecast.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load forecast');
    }
  }
}

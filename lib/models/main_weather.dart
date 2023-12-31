class MainWeather {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;

  MainWeather(
      {required this.temp,
      required this.feelsLike,
      required this.tempMin,
      required this.tempMax,
      required this.pressure,
      required this.humidity});

  factory MainWeather.fromJson(dynamic json) {
    if (json == null) {
      return MainWeather(
          temp: 0.0000,
          feelsLike: 0.0000,
          tempMin: 0.0000,
          tempMax: 0.0000,
          pressure: 0,
          humidity: 0);
    }
    return MainWeather(
        temp: json['temp'],
        feelsLike: double.parse(json['feels_like'].toString()),
        tempMin: json['temp_min'],
        tempMax: json['temp_max'],
        pressure: json['pressure'],
        humidity: json['humidity']);
  }
}

class Forecast {
  final DateTime date;
  final double temperature;
  final String condition;

  Forecast(
      {required this.date, required this.temperature, required this.condition});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      temperature: json['main']['temp'].toDouble(),
      condition: json['weather'][0]['main'],
    );
  }
}

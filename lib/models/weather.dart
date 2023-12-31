class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather(
      {required this.id,
      required this.main,
      required this.description,
      required this.icon});

  factory Weather.fromJson(dynamic json) {
    if (json == null) {
      return Weather(id: 0, main: 'empty', description: 'empty', icon: 'empty');
    }

    return Weather(
        id: json['id'],
        main: json['main'],
        description: json['description'],
        icon: json['icon']);
  }
}

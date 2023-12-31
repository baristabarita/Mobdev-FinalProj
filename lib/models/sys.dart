class Sys {
  final int type;
  final int id;
  final String country;
  final int sunrise;
  final int sunset;

  Sys(
      {required this.type,
      required this.id,
      required this.country,
      required this.sunrise,
      required this.sunset});

  factory Sys.fromJson(dynamic json) {
    if (json == null) {
      return Sys(type: 0, id: 0, country: 'empty', sunrise: 0, sunset: 0);
    }

    return Sys(
        type: json['type'],
        id: json['id'],
        country: json['country'],
        sunrise: json['sunrise'],
        sunset: json['sunset']);
  }
}

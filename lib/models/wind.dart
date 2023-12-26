class Wind {
  final double speed;
  final int deg;

  Wind({required this.speed, required this.deg});

  factory Wind.fromJson(dynamic json) {
    if (json == null) {
      return Wind(speed: 0.0000, deg: 0);
    }

    return Wind(
        speed: double.parse(json['speed'].toString()), deg: json['deg']);
  }
}

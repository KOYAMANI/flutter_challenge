class WindData {
  final String direction;
  final int speed;
  const WindData({required this.direction, required this.speed});

  factory WindData.fromJson(Map data) {
    return WindData(
      direction: data['direction'],
      speed: data['speed'],
    );
  }
}

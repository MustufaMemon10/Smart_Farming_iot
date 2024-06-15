

class WaterValue {
  final int id;
  final double level;

  WaterValue({required this.id, required this.level});

  factory WaterValue.fromJson(Map<String, dynamic> json) {
    return WaterValue(
      id: int.parse(json['sensor_id']),
      level: double.parse(json['water_level']),
    );
  }
}

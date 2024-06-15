

class SoilValue {
  final int id;
  final double moist;

  SoilValue({required this.id, required this.moist});

  factory SoilValue.fromJson(Map<String, dynamic> json) {
    return SoilValue(
      id: int.parse(json['sensor_id']),
      moist: double.parse(json['m_value']),
    );
  }
}

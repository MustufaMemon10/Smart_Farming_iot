

class TempValue {
  final int id;
  final double temperature;
  final double humidity;

  TempValue({required this.id, required this.temperature,required this.humidity});

  factory TempValue.fromJson(Map<String, dynamic> json) {
    return TempValue(
      id: int.parse(json['sensor_id']),
      temperature: double.parse(json['temp_value']),
      humidity: double.parse(json['hum_value']),
    );
  }
}

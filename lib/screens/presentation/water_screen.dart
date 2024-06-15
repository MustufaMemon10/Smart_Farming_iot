import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_farming_app/models/WaterModel.dart';

import '../../models/SoilModel.dart';

class WaterScreen extends StatefulWidget {
  const WaterScreen({super.key});

  @override
  State<WaterScreen> createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  late Future<List<WaterValue>> futureSoilValues;

  @override
  void initState() {
    super.initState();
    futureSoilValues = fetchSensorData();
  }

  Future<List<WaterValue>> fetchSensorData() async {
    final response = await http.get(Uri.parse('https://petrocard.000webhostapp.com/IOTAPI/get_watervalue.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((json) => WaterValue.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load sensor data');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Water Level',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.blue.shade300),
        ),
      ),
      body: FutureBuilder<List<WaterValue>>(
          future: futureSoilValues,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('No Data Found'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No Soil Value Found'),
              );
            }
            else{
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context,index){
                    final soil = snapshot.data![index];
                    return ListTile(
                      title: Text('ID: ${soil.id}'),
                      subtitle: Text('Temperature: ${soil.level}')
                    );
                  });
            }
          }),
    );
  }
}

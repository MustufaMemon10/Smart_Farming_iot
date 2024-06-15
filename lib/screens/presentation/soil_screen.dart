import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/SoilModel.dart'; // Make sure SoilModel.dart is correctly imported

class SoilScreen extends StatefulWidget {
  const SoilScreen({Key? key}) : super(key: key);

  @override
  State<SoilScreen> createState() => _SoilScreenState();
}

class _SoilScreenState extends State<SoilScreen> {
  late Future<List<SoilValue>> futureSoilValues;

  @override
  void initState() {
    super.initState();
    futureSoilValues = fetchSensorData();
  }

  Future<List<SoilValue>> fetchSensorData() async {
    final response = await http.get(Uri.parse('https://petrocard.000webhostapp.com/IOTAPI/get_soilvalue.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((json) => SoilValue.fromJson(json)).toList();
    } else {
      print('Failed to load sensor data. Status Code: ${response.statusCode}');
      throw Exception('Failed to load sensor data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Soil Moisture',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.green.shade500,
          ),
        ),
      ),
      body: FutureBuilder<List<SoilValue>>(
        future: futureSoilValues,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return const Center(
              child: Text('Error Loading Data'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No Soil Value Found'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final soil = snapshot.data![index];
                return ListTile(
                  title: Text('ID: ${soil.id}'),
                  subtitle: Text('Moisture: ${soil.moist}'), // Corrected 'Temperature' to 'Moisture'
                );
              },
            );
          }
        },
      ),
    );
  }
}

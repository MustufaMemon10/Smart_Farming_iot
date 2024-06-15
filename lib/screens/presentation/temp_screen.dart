import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/TempModel.dart';

class TempScreen extends StatefulWidget {
  const TempScreen({super.key});

  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  late Future<List<TempValue>> futureTempValues;

  @override
  void initState() {
    super.initState();
    futureTempValues = fetchSensorData();
  }

  Future<List<TempValue>> fetchSensorData() async {
    final response = await http.get(Uri.parse('https://petrocard.000webhostapp.com/IOTAPI/get_tempvalue.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((json) => TempValue.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load sensor data');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Temperature Value',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.green.shade500),
        ),
      ),
      body: FutureBuilder<List<TempValue>>(
          future: futureTempValues,
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
                child: Text('No Temperature Value Found'),
              );
            }
            else{
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context,index){
                    final temp = snapshot.data![index];
                    return ListTile(
                      title: Text('ID: ${temp.id}'),
                      subtitle: Text('Temperature: ${temp.temperature}°C\nHumidity: ${temp.humidity}%'),
                    );
              });
            }
          }),
    );
  }
}

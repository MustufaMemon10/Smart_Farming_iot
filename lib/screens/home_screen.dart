import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_farming_app/screens/presentation/soil_screen.dart';
import 'package:smart_farming_app/screens/presentation/temp_screen.dart';
import 'package:smart_farming_app/screens/presentation/water_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Smart Farming',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color: Colors.green.shade500),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 100,
                    child: OutlinedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255,246,249,254),
                        ),
                        onPressed: (){
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => const TempScreen()));
                        }, child: const Center(
                      child:
                      Text(
                        'Temperature',
                          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.black)
                      ),
                    )),
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: SizedBox(
                    height: 100,
                    child: OutlinedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFb0c7ff),
                        ),
                        onPressed: (){
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => const SoilScreen()));
                        }, child: const Center(
                      child:
                      Text(
                          'Soil Moisture',
                          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.black)
                      ),
                    )),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20 ,),
          SizedBox(
            height: 120,
            width: 280,
            child: OutlinedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const  Color.fromARGB(255,249,207,239,),
                ),
                onPressed: (){
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => const WaterScreen()));
                }, child: const Center(
              child:
              Text(
                  'Water Level',
                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.black)
              ),
            )),
          ),
        ],
      ),
    );
  }
}

import 'package:car_fuel_efficiency/Pages/braking.dart';
import 'package:flutter/material.dart';
import 'package:segment_display/segment_display.dart';
import 'package:provider/provider.dart';
import 'package:car_fuel_efficiency/Providers/provider.dart';
import 'package:car_fuel_efficiency/Pages/acceleration.dart';
import 'dart:io' show Platform;


//Main UI of all the speed data.
//turns raw data into texts with suitable colour
class SpeedometerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<provider>(context);
    providerData.getSpeedUpdates();
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text(
          "Speedometer",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        backgroundColor: Colors.greenAccent,
        // backgroundColor: Color(0x665ac18e),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                    child: Column(children: <Widget>[
                      Text("Current Speed",
                          style: Theme.of(context).textTheme.bodyText1),
                      SizedBox(
                        height: 10,
                      ),
                      SevenSegmentDisplay(
                          value:
                          '${providerData.speedometer.currentSpeed.toStringAsFixed(2)}',

                          size: 8,
                          backgroundColor: Colors.greenAccent,
                          segmentStyle: HexSegmentStyle(
                              enabledColor: Colors.black,
                              disabledColor: Colors.greenAccent)),

                      Text("mph", style: Theme.of(context).textTheme.bodyText1)
                    ])),
              ),
              //    SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(2.0),
                alignment: Alignment.center,
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle:
                    const TextStyle(fontSize: 40, color: Colors.black),
                  ),
                  child: const Text('Acceleration'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AccelerationPage()));
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(2.0),
                alignment: Alignment.center,
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 40),
                  ),
                  child: const Text('Braking Intensity'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BrakingPage()));
                  },
                ),
              ),
              SizedBox(height: 100),
            ]),
      ),
    );
  }
}
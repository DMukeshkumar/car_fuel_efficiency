import 'package:flutter/material.dart';
import 'package:segment_display/segment_display.dart';
import 'package:car_fuel_efficiency/Providers/provider.dart';
import 'package:provider/provider.dart';

class AccelerationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<provider>(context);
    providerData.getSpeedUpdates();
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: SingleChildScrollView(
        padding:const EdgeInsets.only(top: 100),
        child: Center(
          child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.cent0er,
              children: <Widget>[
                Text("Acceleration ",
                    style: Theme.of(context).textTheme.bodyText1),
                SevenSegmentDisplay(
                  value: "${providerData.speedometer.time0_48}",
                  size: 8,
                  backgroundColor: Colors.greenAccent,
                  segmentStyle: HexSegmentStyle(
                      enabledColor: Colors.black, disabledColor: Colors.greenAccent),
                ),
                Text("Seconds", style: Theme.of(context).textTheme.bodyText1)
              ]),
        ),
      ),
    );
  }
}
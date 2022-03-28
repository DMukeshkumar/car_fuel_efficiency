import 'package:flutter/material.dart';
import 'package:car_fuel_efficiency/Providers/provider.dart';
import 'package:segment_display/segment_display.dart';
import 'package:provider/provider.dart';

//UI page for braking data which pulls data from other files and displays it
class BrakingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<provider>(context);
    providerData.getSpeedUpdates();
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 100),
        child: Center(
          child: Column(children: <Widget>[
            Text("Braking ", style: Theme.of(context).textTheme.bodyText1),
            SevenSegmentDisplay(
              //data is pulled from speedometer_widget page
              value: "${providerData.speedometer.time48_0}",
              size: 8,
              backgroundColor: Colors.greenAccent,
              segmentStyle: HexSegmentStyle(
                  enabledColor: Colors.black,
                  disabledColor: Colors.greenAccent),
            ),
            Text("Seconds", style: Theme.of(context).textTheme.bodyText1)
          ]),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:segment_display/segment_display.dart';
import 'package:provider/provider.dart';
import 'package:car_fuel_efficiency/Providers/provider.dart';

class SpeedometerWidget extends StatelessWidget {

 @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<provider>(context);
    providerData.getSpeedUpdates();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Speedometer",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        backgroundColor: Color(0x665ac18e),
                centerTitle: true,
      ),
      body : SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Column(children: <Widget>[
                  Text("Current Speed",
                      style: Theme.of(context).textTheme.bodyText1),
                  SevenSegmentDisplay(
                      value:
                          '${providerData.speedometer.currentSpeed.toStringAsFixed(2)}',
                      size: 8,
                      backgroundColor: Colors.white,
                      segmentStyle: HexSegmentStyle(
                          enabledColor: Colors.green,
                          disabledColor: Colors.white)),
                  Text("Kmh", style: Theme.of(context).textTheme.bodyText1)
                ])),
              ),
              SizedBox(height:10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(children: <Widget>[
                    Text("From 10 to 30 ",
                        style: Theme.of(context).textTheme.bodyText1),
                    SevenSegmentDisplay(
                      value: "${providerData.speedometer.time10_30}",
                      size: 8,
                      backgroundColor: Colors.white,
                      segmentStyle: HexSegmentStyle(
                          enabledColor: Colors.green,
                          disabledColor: Colors.white),
                    ),
                    Text("Seconds",
                        style: Theme.of(context).textTheme.bodyText1)
                  ]),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(children: <Widget>[
                    Text("From 30 to 10 ",
                        style: Theme.of(context).textTheme.bodyText1),
                    SevenSegmentDisplay(
                        value: "${providerData.speedometer.time30_10}",
                        size: 8,
                        backgroundColor: Colors.white,
                        segmentStyle: HexSegmentStyle(
                            enabledColor: Colors.green,
                            disabledColor: Colors.white)),
                    Text("Seconds",
                        style: Theme.of(context).textTheme.bodyText1)
                  ]),
                ),
              ),
              SizedBox(height: 100),
            ]),
      ),
    );
  }
}

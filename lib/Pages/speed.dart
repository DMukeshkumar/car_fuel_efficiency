import 'package:flutter/material.dart';
import 'package:car_fuel_efficiency/Providers/provider.dart';
import 'package:car_fuel_efficiency/widgets/speedometer_widget.dart';
import 'package:provider/provider.dart';

class SpeedPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => provider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SpeedometerWidget(),
        theme: ThemeData(
            textTheme: TextTheme(
                bodyText1: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                bodyText2: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.green))),
      ),
    );
  }
}


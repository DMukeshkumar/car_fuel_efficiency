import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:car_fuel_efficiency/Providers/provider.dart';
import 'package:car_fuel_efficiency/widgets/speedometer_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_fuel_efficiency/Pages/log_in.dart';

import 'chart.dart';
import 'home.dart';

class SpeedPage extends StatefulWidget {
  @override
  _SpeedPageState createState() => _SpeedPageState();
}

 class _SpeedPageState extends State<SpeedPage>{
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 2;
  final screens = [
    HomePage(),
    ChartPage(),
    SpeedPage(),
    LogInPage(),

  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home,size: 30,),
      Icon(Icons.pie_chart, size: 30),
      Icon(Icons.speed, size: 30),
      Icon(Icons.person, size: 30),
    ];

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


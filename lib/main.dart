import 'package:car_fuel_efficiency/Pages/home.dart';
import 'package:car_fuel_efficiency/Pages/settings.dart';
import 'package:car_fuel_efficiency/Pages/speed.dart';
import 'package:car_fuel_efficiency/Pages/log_in.dart';
import 'package:car_fuel_efficiency/Pages/register.dart';
import 'package:car_fuel_efficiency/Pages/chart.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MainPage());
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 2;

  final screens =[
    HomePage(),
    SettingsPage(),
    SpeedPage(),
    LogInPage(),
    RegisterPage(),
    //ChartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home,size: 30,),
      Icon(Icons.settings, size: 30),
      Icon(Icons.speed, size: 30),
      Icon(Icons.person, size: 30),
      //Icon(Icons.add_chart, size: 30),

    ];

    return MaterialApp(

      home: Scaffold(
        extendBody: true,
        backgroundColor: Colors.white30,
        appBar: AppBar(
          title: Text('Car Fuel Efficiency '),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: screens[index],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            iconTheme: IconThemeData(color: Colors.white),
          ),
          child: CurvedNavigationBar(
            key: navigationKey,
            color: Colors.white30,
            buttonBackgroundColor: Colors.purple,
            backgroundColor: Colors.transparent,
            height: 60,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 200),
            index: index,
            items: items,
            onTap: (index) => setState(() => this.index = index),
          ),
        ),
      ),
    );
  }
}

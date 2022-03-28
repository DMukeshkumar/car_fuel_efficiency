import 'package:car_fuel_efficiency/Pages/speed.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chart.dart';
import 'home.dart';
import 'log_in.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {

  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.getString('username');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmail();
  }

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

    return MaterialApp(
      home: Scaffold(
        extendBody: true,
        backgroundColor: Colors.white30,
        appBar: AppBar(
          title: Text('EcoDrive'),
          backgroundColor: Colors.greenAccent,
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

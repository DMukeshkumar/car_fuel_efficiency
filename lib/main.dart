// @dart=2.9
import 'package:car_fuel_efficiency/Pages/chart.dart';
import 'package:car_fuel_efficiency/Pages/home.dart';
import 'package:car_fuel_efficiency/Pages/speed.dart';
import 'package:car_fuel_efficiency/Pages/log_in.dart';
import 'package:car_fuel_efficiency/Pages/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var username = preferences.getString('username');
  runApp(MaterialApp(home: username == null? LogInPage() : NavigationPage(),));
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

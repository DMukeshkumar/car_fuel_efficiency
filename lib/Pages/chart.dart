import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:car_fuel_efficiency/Providers/provider.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;

class ChartPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.greenAccent,
      ),
      home: MyChartPage(title: 'Flutter Demo Home Page'),

      color: Colors.green,
    );
  }
}

class MyChartPage extends StatefulWidget {
  MyChartPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyChartPageState createState() => _MyChartPageState();
}

class _MyChartPageState extends State<MyChartPage> {

  List<LiveData> fromJson(String strJson){
    final data = jsonDecode(strJson);
    return List<LiveData>.from(data.map((i) => LiveData.fromMap(i)));
  }


  //gets gata from MySQL database using charts.php file written in XAAMP server
  List<LiveData> times = [];
  Future<List<LiveData>> getdata() async{
    List<LiveData> list = [];
    final response =
    await http.get(Uri.parse("http://192.168.1.121/localconnect/charts.php"));
    if (response.statusCode == 200){
      list = fromJson(response.body);
    }
    return list;
  }

  static List<charts.Series<LiveData, String>> chartData(List<LiveData> data){
    return [charts.Series<LiveData, String>(
        id:'speed',
        domainFn: (LiveData s,_) => s.time,
        measureFn: (LiveData s,_) => s.speed,
        data:data)
    ];
  }

  @override
  void initState() {
    getdata().then((value) => times = value);
//Timer.periodic(const Duration(seconds: 1), updateDataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.greenAccent,
            body: Center(
              child: Container(
                height: 400,
                child: charts.BarChart(
                  chartData(times),
                  animate: true,
                ),
              ),
            )
        ));
  }
}

class LiveData {
  final String time;
  final num speed;

  LiveData({required this.time, required this.speed});

  factory LiveData.fromMap(Map<String, dynamic> map){
    return LiveData(time: map["time"], speed: int.parse(map["speed"]));
  }
}
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


/*

 int time = 19;
  void updateDataSource(Timer timer) {
    chartData.add(LiveData(time++, (math.Random().nextInt(60) + 30)));
    chartData.removeAt(0);
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);
  }



            body: SfCartesianChart(
                series: <LineSeries<LiveData, int>>[
                  LineSeries<LiveData, int>(
                    onRendererCreated: (ChartSeriesController controller) {
                      _chartSeriesController = controller;
                    },
                    dataSource: chartData,
                    color: const Color.fromRGBO(192, 108, 132, 1),
                    xValueMapper: (LiveData sales, _) => sales.time,
                    yValueMapper: (LiveData sales, _) => sales.speed,
                  )
                ],
                primaryXAxis: NumericAxis(
                    majorGridLines: const MajorGridLines(width: 0),
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    interval: 3,
                    title: AxisTitle(text: 'Time (seconds)')),
                primaryYAxis: NumericAxis(
                    axisLine: const AxisLine(width: 0),
                    majorTickLines: const MajorTickLines(size: 0),
                    title: AxisTitle(text: 'Internet speed (Mbps)'))))







import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  List<_SpeedData> data = [
    _SpeedData(70, 5),
    _SpeedData(74, 8),
    _SpeedData(79, 5),
    _SpeedData(72, 3),
    _SpeedData(68, 4)
  ];

  @override
void initState(){
    _SpeedData = getSpeedData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCartesianChart(
        //Initialize the chart widget
        primaryXAxis: CategoryAxis(),
        // Chart title
        title: ChartTitle(text: 'Speed vs Acceleration'),
        // Enable legend
        legend: Legend(isVisible: true),
        // Enable tooltip
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries<_SpeedData, double>>[
          LineSeries<_SpeedData, double>(
              dataSource: data,
              xValueMapper: (_SpeedData sales, _) => sales.speed,
              yValueMapper: (_SpeedData sales, _) => sales.acceleration,
              name: 'Speed',
              // Enable data label
              dataLabelSettings: DataLabelSettings(isVisible: true)),
        ],
      ),
    );
  }
}

class _SpeedData {
  _SpeedData(this.speed, this.acceleration);
  final double speed;
  final double acceleration;
}


*/

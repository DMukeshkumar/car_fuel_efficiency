import 'package:flutter/material.dart';

class ChartPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) => Scaffold(

    backgroundColor: Colors.black,
    body: Center(
      child: Text(
        'Data Charts Page',
        style: TextStyle(fontSize: 60, color: Colors.white),
      ),
    ),
  );
}
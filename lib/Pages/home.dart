import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) => Scaffold(

    backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Home Page',
          style: TextStyle(fontSize: 60, color: Colors.white),
        ),
      ),
  );
}
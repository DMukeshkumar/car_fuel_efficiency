import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) => Scaffold(

    backgroundColor: Colors.black,
    body: Center(
      child: Text(
        'Settings',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 60, color: Colors.white),
      ),
    ),
  );
}
import 'package:fhn/constants.dart';
import 'package:fhn/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: kHNOrange),
  );

  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fHN',
      theme: ThemeData(
        primaryColor: kHNOrange,
        primarySwatch: Colors.orange,
        backgroundColor: Color(0xFFF6F6EF),
      ),
      home: Home(),
    );
  }
}

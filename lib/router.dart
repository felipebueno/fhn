import 'package:fhn/screens/comments.dart';
import 'package:fhn/screens/home.dart';
import 'package:flutter/material.dart';

class Router {
  static Map<String, WidgetBuilder> routes = {
    Home.id: (context) => Home(),
    Comments.id: (context) => Comments(),
  };
}

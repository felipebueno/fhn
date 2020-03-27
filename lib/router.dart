import 'package:fhn/pages/home.dart';
import 'package:fhn/pages/post_comments.dart';
import 'package:flutter/material.dart';

class Router {
  static Map<String, WidgetBuilder> routes = {
    Home.id: (context) => Home(),
    Comments.id: (context) => Comments(),
  };
}

import 'package:fhn/pages/comments/comments.dart';
import 'package:fhn/pages/home.dart';
import 'package:flutter/material.dart';

class HNRouter {
  static Map<String, WidgetBuilder> routes = {
    Home.id: (context) => Home(),
    PostComments.id: (context) => PostComments(),
  };
}

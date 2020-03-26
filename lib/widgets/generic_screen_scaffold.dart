import 'package:fhn/constants.dart';
import 'package:fhn/screens/home.dart';
import 'package:flutter/material.dart';

class GenericScreenScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const GenericScreenScaffold({
    Key key,
    this.title,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kHNBGColor,
      appBar: AppBar(
        title: Text(this.title),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () => Navigator.of(context).pushNamed(Home.id)),
        ],
      ),
      body: SingleChildScrollView(child: this.body),
    );
  }
}

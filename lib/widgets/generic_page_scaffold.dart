import 'package:fhn/constants.dart';
import 'package:fhn/pages/home.dart';
import 'package:flutter/material.dart';

class GenericPageScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const GenericPageScaffold({
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
              onPressed: () =>
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(Home.id, (r) => false)),
        ],
      ),
      body: SingleChildScrollView(child: this.body),
    );
  }
}

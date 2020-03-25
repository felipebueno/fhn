import 'package:fhn/constants.dart';
import 'package:flutter/material.dart';

class HNAppBar extends StatelessWidget {
  const HNAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: kHNOrange,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            'assets/icon/icon.jpg',
            width: 32,
            height: 32,
          ),
          Expanded(
            child: Text(
              'Hacker News',
              style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

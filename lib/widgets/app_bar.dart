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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.hd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Hacker News',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  'new | past | comments | ask | show | jobs | submit',
                  style: TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
          Text(
            'login',
            style: TextStyle(fontSize: 11),
          )
        ],
      ),
    );
  }
}

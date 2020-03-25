import 'package:fhn/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class Footer extends StatelessWidget {
  const Footer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('More'),
        Divider(
          color: kHNOrange,
          height: 2.0,
          thickness: 2.0,
        ),
        Container(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Applications are open for YC Summer 2020'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Guidelines | FAQ | Lists | Bookmarklet | Legal | Apply to YC | Contact',
                  textAlign: TextAlign.center,
                ),
              ),
              Text('Search:'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      border: InputBorder.none,
                      hintText: 'Enter a search term'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

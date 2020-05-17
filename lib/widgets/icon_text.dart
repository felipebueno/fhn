import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final MainAxisAlignment horizontalAlignment;

  const IconText(
      {Key key,
      @required this.icon,
      this.color,
      @required this.text,
      this.horizontalAlignment = MainAxisAlignment.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? Theme.of(context).textTheme.subtitle1.color;

    return Row(
      mainAxisAlignment: this.horizontalAlignment,
      children: <Widget>[
        Icon(
          this.icon,
          color: color,
        ),
        SizedBox(width: 4),
        Text(
          this.text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

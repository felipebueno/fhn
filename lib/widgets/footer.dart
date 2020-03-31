import 'package:fhn/constants.dart';
import 'package:fhn/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:social_media_buttons/social_media_icons.dart';

class Footer extends StatelessWidget {
  const Footer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kHNOrange,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InkWell(
          onTap: () => Utils.launchURL('https://github.com/felipebueno/fhn'),
          child: IconText(
            icon: SocialMediaIcons.github_circled,
            text: 'Source',
            color: Colors.white,
            horizontalAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final MainAxisAlignment horizontalAlignment;

  const IconText({Key key,
    @required this.icon,
    this.color = Colors.black,
    @required this.text,
    this.horizontalAlignment = MainAxisAlignment.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: this.horizontalAlignment,
      children: <Widget>[
        Icon(
          this.icon,
          color: this.color,
        ),
        SizedBox(width: 4),
        Text(
          this.text,
          style: TextStyle(
            color: this.color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

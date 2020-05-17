import 'package:fhn/constants.dart';
import 'package:fhn/utils.dart';
import 'package:fhn/widgets/icon_text.dart';
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
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InkWell(
          onTap: () => Utils.launchURL('https://github.com/felipebueno/fhn'),
          child: IconText(
            icon: SocialMediaIcons.github_circled,
            text: 'Source',
            color: kHNWhite,
            horizontalAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}

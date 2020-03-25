import 'package:fhn/constants.dart';
import 'package:fhn/widgets/app_bar.dart';
import 'package:fhn/widgets/footer.dart';
import 'package:fhn/widgets/top_stories.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kHNBGColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            HNAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  Container(
                    width: double.infinity,
                    child: TopStories(),
                  ),
                  Footer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

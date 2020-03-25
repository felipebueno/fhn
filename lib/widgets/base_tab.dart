import 'package:fhn/widgets/footer.dart';
import 'package:flutter/material.dart';

class BaseTab extends StatelessWidget {
  final Widget body;

  const BaseTab({
    Key key,
    @required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          this.body,
          Footer(),
        ],
      ),
    );
  }
}

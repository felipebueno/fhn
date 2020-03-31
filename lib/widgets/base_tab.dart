import 'package:fhn/constants.dart';
import 'package:fhn/utils.dart';
import 'package:fhn/widgets/footer.dart';
import 'package:flutter/material.dart';

class BaseTab extends StatefulWidget {
  final Widget body;

  const BaseTab({
    Key key,
    @required this.body,
  }) : super(key: key);

  @override
  _BaseTabState createState() => _BaseTabState();
}

class _BaseTabState extends State<BaseTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          this.widget.body,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              child: OutlineButton(
                textColor: kHNOrange,
                child: Text('MORE'),
                borderSide: BorderSide(width: 2.0, color: kHNOrange),
                onPressed: () {
                  Utils.showInfo(context, 'NOT IMPLEMENTED YET');
                },
              ),
            ),
          ),
          Footer(),
        ],
      ),
    );
  }
}

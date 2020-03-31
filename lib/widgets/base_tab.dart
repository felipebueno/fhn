import 'package:fhn/constants.dart';
import 'package:fhn/utils.dart';
import 'package:fhn/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BaseTab<TBloc extends Bloc<dynamic, dynamic>> extends StatefulWidget {
  final Widget body;
  final onRefresh;

  const BaseTab({Key key, @required this.body, this.onRefresh})
      : super(key: key);

  @override
  _BaseTabState<TBloc> createState() => _BaseTabState<TBloc>();
}

class _BaseTabState<TBloc extends Bloc<dynamic, dynamic>>
    extends State<BaseTab<TBloc>>
    with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async {
    BlocProvider.of<TBloc>(context).add(widget.onRefresh);
    _refreshController.refreshCompleted();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return LayoutBuilder(
      builder: (context, constraint) =>
          SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      Expanded(child: this.widget.body),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          child: OutlineButton(
                            textColor: kHNOrange,
                            child: Text('MORE'),
                            borderSide: BorderSide(width: 2.0,
                                color: kHNOrange),
                            onPressed: () {
                              Utils.showInfo(context, 'NOT IMPLEMENTED YET');
                            },
                          ),
                        ),
                      ),
                      Footer(),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}

import 'package:fhn/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BaseTab<TBloc extends Bloc<dynamic, dynamic>> extends StatefulWidget {
  final Widget body;
  final onRefresh;
  final onMoreTap;

  const BaseTab({
    Key key,
    @required this.body,
    this.onRefresh,
    this.onMoreTap,
  }) : super(key: key);

  @override
  _BaseTabState<TBloc> createState() => _BaseTabState<TBloc>();
}

class _BaseTabState<TBloc extends Bloc<dynamic, dynamic>>
    extends State<BaseTab<TBloc>> with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  TBloc _blocProvider;

  void _onRefresh() async {
    _blocProvider.add(widget.onRefresh);
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    _blocProvider = BlocProvider.of<TBloc>(context);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return LayoutBuilder(
      builder: (context, constraint) => SmartRefresher(
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
                        textColor: Theme.of(context).buttonColor,
                        child: Text('MORE'),
                        borderSide: BorderSide(
                          width: 1.0,
                          color: Theme.of(context).buttonColor,
                        ),
                        onPressed: () {
                          _blocProvider.add(widget.onMoreTap);
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseBlocConsumer<TBloc extends Bloc<dynamic, TState>, TState>
    extends StatefulWidget {
  final BlocWidgetListener<TState> listener;
  final BlocWidgetBuilder<TState> builder;
  final Function onReady;

  BaseBlocConsumer({this.listener, this.builder, this.onReady});

  @override
  _BaseBlocConsumerState<TBloc, TState> createState() =>
      _BaseBlocConsumerState<TBloc, TState>();
}

class _BaseBlocConsumerState<TBloc extends Bloc<dynamic, TState>, TState>
    extends State<BaseBlocConsumer<TBloc, TState>> {
  @override
  void initState() {
    if (widget.onReady != null) {
      widget.onReady();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TBloc, TState>(
      listener: widget.listener,
      builder: widget.builder,
    );
  }
}

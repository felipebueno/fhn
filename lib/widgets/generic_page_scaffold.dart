import 'package:fhn/data/post_repository.dart';
import 'package:fhn/pages/comments/comments_bloc.dart';
import 'package:fhn/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenericPageScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const GenericPageScaffold({
    Key key,
    this.title,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () => Navigator.popUntil(
              context,
              ModalRoute.withName(Home.id),
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => CommentsBloc(
          CommentsInitial(),
          RealPostRepository(),
        ),
        child: LayoutBuilder(
          builder: (context, constraint) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(child: this.body),
            ),
          ),
        ),
      ),
    );
  }
}

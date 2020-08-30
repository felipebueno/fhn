import 'package:fhn/data/models/post.dart';
import 'package:fhn/data/post_repository.dart';
import 'package:fhn/pages/comments/comments_bloc.dart';
import 'package:fhn/widgets/comment_item.dart';
import 'package:fhn/widgets/generic_page_scaffold.dart';
import 'package:fhn/widgets/post_item.dart';
import 'package:fhn/widgets/posts/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostComments extends StatelessWidget {
  static const String id = 'comments';

  @override
  Widget build(BuildContext context) {
    final Post post = ModalRoute.of(context).settings.arguments;
    return BlocProvider(
      create: (context) => CommentsBloc(
        CommentsInitial(),
        RealPostRepository(),
      ),
      child: GenericPageScaffold(
        title: 'Comments',
        body: Column(
          children: <Widget>[
            PostItem(post, isCommentsPage: true),
            Divider(
              height: 24,
              color: Theme.of(context).buttonColor,
            ),
            Expanded(child: CommentList(post: post)),
          ],
        ),
      ),
    );
  }
}

class CommentList extends StatefulWidget {
  const CommentList({
    Key key,
    @required this.post,
  }) : super(key: key);

  final Post post;

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CommentsBloc>(context).add(GetComments(widget.post));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsBloc, CommentsState>(
      builder: (context, state) {
        if (state is CommentsInitial) {
          return PostListUtils.buildInitialState(context);
        } else if (state is CommentsLoading) {
          return PostListUtils.buildLoadingState();
        } else if (state is CommentsLoaded) {
          return state.comments == null || state.comments.length == 0
              ? Container()
              : Column(
                  children: state.comments
                      .map(
                        (comment) => Column(
                          children: <Widget>[
                            CommentItem(comment),
                            Divider(
                              height: 24,
                              color: Theme.of(context).buttonColor,
                            ),
                          ],
                        ),
                      )
                      .toList(),
                );
        } else if (state is CommentsError) {
          return PostListUtils.buildInitialState(context);
        }
        return Container();
      },
    );
  }
}

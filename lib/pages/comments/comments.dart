import 'package:fhn/data/models/post.dart';
import 'package:fhn/widgets/comment_item.dart';
import 'package:fhn/widgets/generic_page_scaffold.dart';
import 'package:fhn/widgets/post_item.dart';
import 'package:flutter/material.dart';

class PostComments extends StatelessWidget {
  static const String id = 'comments';

  @override
  Widget build(BuildContext context) {
    final Post post = ModalRoute.of(context).settings.arguments;
    return GenericPageScaffold(
      title: 'Comments',
      body: Column(
        children: <Widget>[
          PostItem(post, isCommentsPage: true),
          post.comments == null
              ? Container()
              : Column(
            children: post.comments
                .map(
                  (comment) => CommentItem(comment),
            )
                .toList(),
          ),
        ],
      ),
    );
  }
}

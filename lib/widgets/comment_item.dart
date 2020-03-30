import 'package:fhn/constants.dart';
import 'package:fhn/data/models/post.dart';
import 'package:fhn/pages/comments/comments.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  final Post post;

  const CommentItem(
    this.post, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (this.post.comments == null) return;

        Navigator.of(context).pushNamed(
          PostComments.id,
          arguments: this.post,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 24.0,
          right: 8.0,
          top: 8.0,
          bottom: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              '${this.post.text} ',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            SizedBox(height: 8.0),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: '${this.post.by}',
                    style: TextStyle(color: kHNGrey),
                  ),
                  TextSpan(
                    text: ' ${this.post.timeAgo}',
                    style: TextStyle(color: kHNGrey),
                  ),
                  TextSpan(
                    text: this.post.kids == null
                        ? ''
                        : ' | ${this.post.kids.length} comments',
                    style: TextStyle(color: kHNGrey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

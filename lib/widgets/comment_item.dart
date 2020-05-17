import 'package:fhn/data/models/post.dart';
import 'package:fhn/pages/comments/comments.dart';
import 'package:fhn/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class CommentItem extends StatelessWidget {
  final Post post;

  const CommentItem(
    this.post, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle subtitle1 = Theme.of(context).textTheme.subtitle1;
    final TextStyle subtitle2 = Theme.of(context).textTheme.subtitle2;

    return InkWell(
      onTap: () {
        if (this.post.kids == null || this.post.kids.length == 0) return;

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
            Html(
              data: '${this.post.text ?? 'DELETED'} ',
              defaultTextStyle: subtitle1,
              onLinkTap: (url) {
                Utils.launchURL(url);
              },
            ),
            SizedBox(height: 8.0),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: '${this.post.by ?? 'deleted'}',
                    style: subtitle2,
                  ),
                  TextSpan(
                    text: ' ${this.post.timeAgo}',
                    style: subtitle2,
                  ),
                  TextSpan(
                    text: this.post.kids == null
                        ? ''
                        : ' | ${this.post.kids.length} comments',
                    style: subtitle2,
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

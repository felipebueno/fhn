import 'package:fhn/constants.dart';
import 'package:fhn/data/models/post.dart';
import 'package:fhn/pages/comments/comments.dart';
import 'package:fhn/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PostItem extends StatelessWidget {
  final Post post;
  final bool isCommentsPage;

  const PostItem(this.post, {
    Key key,
    this.isCommentsPage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.isCommentsPage || this.post.type == 'job'
          ? () {
        if (this.post.url == null) return;

        Utils.launchURL(this.post.url);
      }
          : () {
        Navigator.of(context).pushNamed(
          PostComments.id,
          arguments: this.post,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            this.isCommentsPage
                ? Container()
                : Container(
              width: 32.0,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  '${this.post.index}.',
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Html(
                    data: '${this.post.title ?? this.post.text} ',
                    defaultTextStyle:
                    TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  this.post.url == null
                      ? Container()
                      : RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '(',
                          style: TextStyle(color: kHNGrey),
                        ),
                        TextSpan(
                          text: '${this.post.host}',
                          style: TextStyle(color: kHNGrey),
                        ),
                        TextSpan(
                          text: ')',
                          style: TextStyle(color: kHNGrey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        this.post.type != 'story'
                            ? TextSpan()
                            : TextSpan(
                          text: '${this.post.score} points by ',
                          style: TextStyle(color: kHNGrey),
                        ),
                        this.post.type == 'job'
                            ? TextSpan()
                            : TextSpan(
                          text: '${this.post.by}',
                          style: TextStyle(color: kHNGrey),
                        ),
                        TextSpan(
                          text: ' ${this.post.timeAgo}',
                          style: TextStyle(color: kHNGrey),
                        ),
                        this.post.type != 'story'
                            ? TextSpan()
                            : TextSpan(
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
          ],
        ),
      ),
    );
  }
}

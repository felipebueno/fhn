import 'package:fhn/data/models/post.dart';
import 'package:fhn/pages/comments/comments.dart';
import 'package:fhn/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PostItem extends StatelessWidget {
  final Post post;
  final bool isCommentsPage;

  const PostItem(
    this.post, {
    Key key,
    this.isCommentsPage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle subtitle1 = Theme.of(context).textTheme.subtitle1;
    final TextStyle subtitle2 = Theme.of(context).textTheme.subtitle2;

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
            this.isCommentsPage || this.post.type == 'job'
                ? Container()
                : Container(
                    width: 32.0,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        '${this.post.index}.',
                        textAlign: TextAlign.end,
                        style: subtitle2,
                      ),
                    ),
                  ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Html(
                    data: '${this.post.title ?? this.post.text} ',
                    defaultTextStyle: subtitle1,
                    onLinkTap: (url) {
                      Utils.launchURL(url);
                    },
                  ),
                  this.post.url == null
                      ? Container()
                      : RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '(',
                                style: subtitle2,
                              ),
                              TextSpan(
                                text: '${this.post.host}',
                                style: subtitle2,
                              ),
                              TextSpan(
                                text: ')',
                                style: subtitle2,
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
                                style: subtitle2,
                              ),
                        this.post.type == 'job'
                            ? TextSpan()
                            : TextSpan(
                                text: '${this.post.by}',
                                style: subtitle2,
                              ),
                        TextSpan(
                          text: ' ${this.post.timeAgo}',
                          style: subtitle2,
                        ),
                        this.post.type != 'story'
                            ? TextSpan()
                            : TextSpan(
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
          ],
        ),
      ),
    );
  }
}

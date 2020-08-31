import 'package:fhn/pages/comments/comments.dart';
import 'package:fhn/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hnpwa_client/hnpwa_client.dart';

class PostItem extends StatelessWidget {
  final int place;
  final FeedItem post;
  final bool isCommentsPage;
  final bool isJobPage;

  const PostItem(
    this.place,
    this.post, {
    Key key,
    this.isCommentsPage = false,
    this.isJobPage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle subtitle1 = Theme.of(context).textTheme.subtitle1;
    final TextStyle subtitle2 = Theme.of(context).textTheme.subtitle2;

    return InkWell(
      onTap: this.isCommentsPage || this.post.type == ItemType.job
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
            this.isCommentsPage || isJobPage
                ? Container()
                : Container(
                    width: 32.0,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        '${this.place}.',
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
                    data: '${this.post.title} ',
                    defaultTextStyle: subtitle1,
                    onLinkTap: (url) {
                      Utils.launchURL(url);
                    },
                  ),
                  this.post.domain == null
                      ? Container()
                      : RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '(',
                                style: subtitle2,
                              ),
                              TextSpan(
                                text: '${this.post.domain}',
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
                        this.post.type != ItemType.story
                            ? TextSpan()
                            : TextSpan(
                                text: '${this.post.points} points by ',
                                style: subtitle2,
                              ),
                        this.post.type == ItemType.job
                            ? TextSpan()
                            : TextSpan(
                                text: '${this.post.user}',
                                style: subtitle2,
                              ),
                        TextSpan(
                          text: ' ${this.post.timeAgo}',
                          style: subtitle2,
                        ),
                        this.post.type != ItemType.story
                            ? TextSpan()
                            : TextSpan(
                                text: this.post.commentsCount == 0
                                    ? ' | discuss'
                                    : ' | ${this.post.commentsCount} comments',
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

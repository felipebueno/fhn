import 'package:fhn/constants.dart';
import 'package:fhn/data/models/post.dart';
import 'package:fhn/pages/post_comments.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PostItem extends StatelessWidget {
  final Post post;
  final bool isCommentsPage;

  const PostItem(this.post, {
    Key key,
    this.isCommentsPage = false,
  }) : super(key: key);

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.isCommentsPage || this.post.type == 'job'
          ? () {
        if (this.post.url == null) return;

        _launchURL(this.post.url);
      }
          : () {
        Navigator.of(context).pushNamed(
          Comments.id,
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
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '${this.post.title ?? this.post.text} ',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        TextSpan(
                          text: this.post.url == null ? '' : '(',
                          style: TextStyle(color: kHNGrey),
                        ),
                        TextSpan(
                          text:
                          this.post.url == null ? '' : '${this.post.host}',
                          style: TextStyle(color: kHNGrey),
                        ),
                        TextSpan(
                          text: this.post.url == null ? '' : ')',
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

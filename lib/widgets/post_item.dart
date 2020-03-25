import 'package:fhn/constants.dart';
import 'package:fhn/models/post.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  final Post post;

  const PostItem({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Container(
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
                        text: '${this.post.title} ',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      TextSpan(
                        text: this.post.url == null ? '' : '(',
                        style: TextStyle(color: kHNGrey),
                      ),
                      TextSpan(
                        text: this.post.url == null ? '' : '${this.post.host}',
                        style: TextStyle(
                          color: kHNGrey,
                          decoration: TextDecoration.underline,
                        ),
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
                      TextSpan(
                        text: '${this.post.score} points by ',
                        style: TextStyle(color: kHNGrey),
                      ),
                      TextSpan(
                        text: '${this.post.by}',
                        style: TextStyle(
                          color: kHNGrey,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: ' ${this.post.timeAgo}',
                        style: TextStyle(color: kHNGrey),
                      ),
                      TextSpan(
                        text: this.post.kids == null
                            ? ''
                            : ' | ${this.post.kids.length} comments',
                        style: TextStyle(
                          color: kHNGrey,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

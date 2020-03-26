import 'package:fhn/models/post.dart';
import 'package:fhn/widgets/post_item.dart';
import 'package:flutter/material.dart';

class AskPosts extends StatelessWidget {
  const AskPosts({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Post> posts = List<Post>.generate(
      30,
      (index) => Post(
        index: index + 1,
        by: 'whoishiring',
        descendants: 680,
        id: 9127232,
        kids: [9127461, 9128292, 9127721, 9127410],
        score: 413,
        time: 1425222252,
        title: 'Ask HN: Who is hiring? (March 2015)',
        text:
            'Please lead with the location of the position and include the keywords INTERN, REMOTE, or VISA if the corresponding sort of candidate is welcome. Feel free to post any job that may interest HN readers from executive assistant to machine learning expert to CTO.<p>Please do not post recruiting firms or job boards.',
        type: 'story',
      ),
    );

    return Column(
      children: posts
          .map(
            (post) => PostItem(post),
          )
          .toList(),
    );
  }
}

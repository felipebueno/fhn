import 'package:fhn/models/post.dart';
import 'package:fhn/widgets/post_item.dart';
import 'package:flutter/material.dart';

class TopPosts extends StatelessWidget {
  const TopPosts({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Post> posts = List<Post>.generate(
      30,
          (index) =>
          Post(
        index: index + 1,
        by: 'dhouston',
        descendants: 71,
        id: 8863,
        kids: [9224, 8917, 8876],
        score: 104,
        time: 1175714200,
        title: 'My YC app: Dropbox - Throw away your USB drive',
        type: 'story',
        url: 'http://www.getdropbox.com/u/2/screencast.html',
      ),
    );

    return Column(
      children: posts
          .map(
            (post) => PostItem(post: post),
      )
          .toList(),
    );
  }
}

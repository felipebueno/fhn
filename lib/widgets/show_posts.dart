import 'package:fhn/models/post.dart';
import 'package:fhn/widgets/post_item.dart';
import 'package:flutter/material.dart';

class ShowPosts extends StatelessWidget {
  const ShowPosts({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Post> posts = List<Post>.generate(
      30,
      (index) => Post(
        index: index + 1,
        by: 'aclarembeau',
        descendants: 2,
        id: 22662135,
        kids: [22662614],
        score: 11,
        time: 1584952403,
        title: 'Show HN: Fiwit – The single tool to manage your internal IT',
        type: 'story',
        url: 'https://www.fiwit.io',
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

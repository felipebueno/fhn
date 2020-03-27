import 'package:fhn/data/models/post.dart';
import 'package:fhn/widgets/post_item.dart';
import 'package:flutter/material.dart';

class JobPosts extends StatelessWidget {
  const JobPosts({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Post> posts = List<Post>.generate(
      30,
      (index) => Post(
        index: index + 1,
        by: 'mcarvin',
        id: 22366248,
        score: 1,
        time: 1582125949,
        title:
            'SmartAsset (YC S12) Is Hiring a Senior Software Engineer in NYC',
        type: 'job',
        url: 'https://smartasset.com/careers/?gh_jid=4594630002',
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

import 'package:fhn/models/Story.dart';
import 'package:fhn/widgets/StoryItem.dart';
import 'package:flutter/material.dart';

class TopStories extends StatelessWidget {
  const TopStories({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Story> stories = List<Story>.generate(
      30,
      (index) => Story(
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
      children: stories
          .map(
            (story) => StoryItem(story: story),
      )
          .toList(),
    );
  }
}

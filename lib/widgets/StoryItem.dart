import 'package:fhn/models/Story.dart';
import 'package:flutter/material.dart';

class StoryItem extends StatelessWidget {
  final Story story;

  const StoryItem({Key key, this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('${this.story.index}.'),
            Icon(
              Icons.arrow_drop_up,
              size: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(this.story.title),
                Text('(${this.story.host})'),
                Text(
                    '${this.story.score} points by ${this.story.by} ${this.story.time} ago | ${this.story.kids.length} comments'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:core';

import 'package:timeago/timeago.dart' as timeago;

class Post {
  final int index;
  final String by; // The username of the item's author.
  final int
  descendants; // In the case of stories or polls, the total comment count.
  final int id; // The item's unique id.
  final List<int>
  kids; // The ids of the item's comments, in ranked display order.
  final int score; // The story's score, or the votes for a pollopt.
  final int time; // Creation date of the item, in Unix Time.
  final String title; // My YC app: Dropbox - Throw away your USB drive
  final String type; // One of "job", "story", "comment", "poll", or "pollopt".
  final String url; // The URL of the story.

  Post({
    this.index,
    this.by,
    this.descendants,
    this.id,
    this.kids,
    this.score,
    this.time,
    this.title,
    this.type,
    this.url,
  });

  String get host =>
      Uri
          .parse(this.url)
          .host
          .replaceFirst('www.', '');

  String get timeAgo =>
      timeago.format(DateTime.fromMillisecondsSinceEpoch(this.time * 1000));

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      by: json['by'],
      descendants: json['descendants'],
      id: json['id'],
      kids: json['kids'] != null ? new List<int>.from(json['kids']) : null,
      score: json['score'],
      time: json['time'],
      title: json['title'],
      type: json['type'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['by'] = this.by;
    data['descendants'] = this.descendants;
    data['id'] = this.id;
    data['score'] = this.score;
    data['time'] = this.time;
    data['title'] = this.title;
    data['type'] = this.type;
    data['url'] = this.url;
    if (this.kids != null) {
      data['kids'] = this.kids;
    }

    return data;
  }
}

import 'dart:core';

import 'package:timeago/timeago.dart' as timeago;

class Story {
  final int index;
  final String by; // dhouston
  final int descendants; // 71
  final int id; // 8863
  final List<int> kids;
  final int score; // 104
  final int time; // 1175714200
  final String title; // My YC app: Dropbox - Throw away your USB drive
  final String type; // story
  final String url; // http://www.getdropbox.com/u/2/screencast.html

  Story({
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
          .host;

  String get timeAgo => timeago.format(DateTime(this.time));

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
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

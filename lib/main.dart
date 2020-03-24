import 'package:fhn/models/Story.dart';
import 'package:fhn/widgets/StoryItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const kHNOrange = Color(0xFFFF6600);
const kHNBGColor = Color(0xFFF6F6EF);

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        backgroundColor: Color(0xFFF6F6EF),
      ),
      home: HomePage(title: 'Hacker News'),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kHNBGColor,
      appBar: buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: TopStories(),
              ),
            ),
          ),
          Footer(),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.hd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  this.title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  'new | past | comments | ask | show | jobs | submit',
                  style: TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
          Text(
            'login',
            style: TextStyle(fontSize: 11),
          )
        ],
      ),
      backgroundColor: kHNOrange,
    );
  }
}

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: stories.map((story) => StoryItem(story: story)).toList(),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('More'),
        Divider(
          color: kHNOrange,
          height: 2.0,
          thickness: 2.0,
        ),
        Container(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Applications are open for YC Summer 2020'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Guidelines | FAQ | Support | API | Security | Lists | Bookmarklet | Legal | Apply to YC | Contact'),
              ),
              Text('Search:'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      border: InputBorder.none,
                      hintText: 'Enter a search term'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

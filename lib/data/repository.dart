import 'dart:math';

import 'package:fhn/data/models/post.dart';

enum PostType {
  top,
  ask,
  show,
  job,
}

abstract class PostRepository {
  Future<List<Post>> fetchPosts(PostType postType);
}

class FakePostRepository implements PostRepository {
  double cachedTempCelsius;

  @override
  Future<List<Post>> fetchPosts(PostType type) {
    // Simulate network delay
    return Future.delayed(
      Duration(seconds: 1),
      () {
        final random = Random();

        // Simulate some network error
        if (random.nextBool()) {
//          throw NetworkError();
        }

        List<Post> posts;
        switch (type) {
          case PostType.top:
            posts = _buildTopPostList();

            break;

          case PostType.ask:
            posts = _buildAskPostList();

            break;

          case PostType.show:
            posts = _buildShowPostList();

            break;

          default:
            break;
        }

        // Return "fetched" posts
        return posts;
      },
    );
  }

  List<Post> _buildTopPostList() {
    return List<Post>.generate(
      30,
      (index) => Post(
        index: index + 1,
        by: 'dhouston',
        descendants: 71,
        id: 8863,
        kids: [
          9224,
          8917,
          8876,
          9224,
          8917,
          8876,
          9224,
          8917,
          8876,
          9224,
        ],
        score: 104,
        time: 1175714200,
        title: 'My YC app: Dropbox - Throw away your USB drive',
        type: 'story',
        url: 'http://www.getdropbox.com/u/2/screencast.html',
        comments: List<Post>.generate(
          10,
          (index) => Post(
            by: "norvig",
            id: 2921983,
            kids: [2922709, 2922573, 2922140, 2922141],
            parent: 2921506,
            text:
                "Aw shucks, guys ... you make me blush with your compliments.<p>Tell you what, Ill make a deal: I'll keep writing if you keep reading. K?",
            time: 1314211127,
            type: "comment",
            comments: List<Post>.generate(
              4,
              (index) => Post(
                by: "norvig",
                id: 2921983,
                kids: [2922709, 2922573, 2922140, 2922141],
                parent: 2921506,
                text:
                    "Aw shucks, guys ... you make me blush with your compliments.<p>Tell you what, Ill make a deal: I'll keep writing if you keep reading. K?",
                time: 1314211127,
                type: "comment",
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Post> _buildAskPostList() {
    return List<Post>.generate(
      30,
          (index) =>
          Post(
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
  }

  List<Post> _buildShowPostList() {
    return List<Post>.generate(
      30,
          (index) =>
          Post(
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
  }
}

class NetworkError extends Error {}

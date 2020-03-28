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
          throw NetworkError();
        }

        List<Post> posts;
        switch (type) {
          case PostType.top:
            posts = _buildTopPostList();

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
}

class NetworkError extends Error {}

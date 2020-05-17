import 'dart:math';

import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:fhn/data/models/post.dart';

enum PostType {
  top,
  ask,
  show,
  job,
}

abstract class PostRepository {
  Future<List<Post>> fetchPosts(PostType postType);

  Future<List<Post>> fetchMorePosts(PostType postType, int from, int to);

  Future<List<Post>> fetchComments(Post post);
}

class RealPostRepository implements PostRepository {
  static const apiUrl = 'https://hacker-news.firebaseio.com/v0';
  final Dio dio = Dio();

  @override
  Future<List<Post>> fetchPosts(PostType postType) async {
    String stories = '';

    switch (postType) {
      case PostType.top:
        stories = 'topstories';

        break;

      case PostType.ask:
        stories = 'askstories';

        break;

      case PostType.show:
        stories = 'showstories';

        break;

      case PostType.job:
        stories = 'jobstories';

        break;

      default:
        break;
    }

    final response = await dio.get('$apiUrl/$stories.json');
    if (response.statusCode == 200) {
      List<dynamic> ids = response.data;
      return _fetchItems(ids, 0, 30);
    } else {
      throw Exception('error fetching posts');
    }
  }

  @override
  Future<List<Post>> fetchMorePosts(PostType postType, int from, int to) async {
    String stories = '';

    switch (postType) {
      case PostType.top:
        stories = 'topstories';

        break;

      case PostType.ask:
        stories = 'askstories';

        break;

      case PostType.show:
        stories = 'showstories';

        break;

      case PostType.job:
        stories = 'jobstories';

        break;

      default:
        break;
    }

    final response = await dio.get('$apiUrl/$stories.json');
    if (response.statusCode == 200) {
      List<dynamic> ids = response.data;
      return _fetchItems(ids.toList(), from, to);
    } else {
      throw Exception('Error fetching more posts');
    }
  }

  @override
  Future<List<Post>> fetchComments(Post post) async =>
      _fetchItems(post.kids, 0, post.kids.length);

  Future<List<Post>> _fetchItems(List<dynamic> ids, int from, int to) async {
    List<Post> posts = [];

    for (var i = from; i < to; ++i) {
      if (i >= ids.length) break;

      final response = await dio.get('$apiUrl/item/${ids[i]}.json');

      if (response.data == null) continue; // Post deleted?

      if (response.statusCode == 200) {
        final post = Post.fromJson(response.data);
        post.index = i + 1;

        posts.add(post);
      }
    }

    return posts;
  }
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

          case PostType.job:
            posts = _buildJobPostList();

            break;

          default:
            break;
        }

        // Return 'fetched' posts
        return posts;
      },
    );
  }

  @override
  Future<List<Post>> fetchComments(Post post) {
    // TODO: implement fetchComments
    throw UnimplementedError();
  }

  List<Post> _buildTopPostList() {
    final faker = Faker();
    return List<Post>.generate(
      30,
      (index) => Post(
        index: index + 1,
        by: faker.internet.userName(),
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
        title: faker.lorem.sentence(),
        type: 'story',
        url: 'http://www.getdropbox.com/u/2/screencast.html',
        comments: List<Post>.generate(
          10,
          (index) => Post(
            by: faker.internet.userName(),
            id: 2921983,
            kids: [2922709, 2922573, 2922140, 2922141],
            parent: 2921506,
            text: faker.lorem.sentence(),
            time: 1314211127,
            type: 'comment',
            comments: List<Post>.generate(
              4,
              (index) => Post(
                by: faker.internet.userName(),
                id: 2921983,
                kids: [2922709, 2922573, 2922140, 2922141],
                parent: 2921506,
                text: faker.lorem.sentence(),
                time: 1314211127,
                type: 'comment',
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
            by: faker.internet.userName(),
            descendants: 680,
            id: 9127232,
            kids: [9127461, 9128292, 9127721, 9127410],
            score: 413,
            time: 1425222252,
            title: 'Ask HN: ${faker.lorem.sentence()}?',
            text: faker.lorem.sentence(),
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
            by: faker.internet.userName(),
            descendants: 2,
            id: 22662135,
            kids: [22662614],
            score: 11,
            time: 1584952403,
            title: 'Show HN: ${faker.lorem.sentence()}',
            type: 'story',
            url: 'https://www.fiwit.io',
          ),
    );
  }

  List<Post> _buildJobPostList() {
    return List<Post>.generate(
      30,
          (index) =>
          Post(
            index: index + 1,
            by: faker.internet.userName(),
            id: 22366248,
            score: 1,
            time: 1582125949,
            title:
            'SmartAsset (YC S12) Is Hiring a Senior Software Engineer in NYC',
            type: 'job',
            url: 'https://smartasset.com/careers/?gh_jid=4594630002',
          ),
    );
  }

  @override
  Future<List<Post>> fetchMorePosts(PostType postType, int from, int to) {
    throw UnimplementedError();
  }
}

class NetworkError extends Error {}

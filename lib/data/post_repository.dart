import 'package:hnpwa_client/hnpwa_client.dart';

enum PostType {
  top,
  ask,
  show,
  job,
}

abstract class IPostRepository {
  Future<List<FeedItem>> fetchPosts(PostType postType);

  Future<List<FeedItem>> fetchMorePosts(PostType postType, int page);

  Future<List<Item>> fetchComments(FeedItem post);
}

class PostRepository implements IPostRepository {
  final client = HnpwaClient();

  @override
  Future<List<FeedItem>> fetchPosts(PostType postType) async {
    switch (postType) {
      case PostType.top:
        final feed = await client.news();

        return feed.items;

      case PostType.ask:
        final feed = await client.ask();

        return feed.items;

      case PostType.show:
        final feed = await client.show();

        return feed.items;

      case PostType.job:
        final feed = await client.jobs();

        return feed.items;

      default:
        return null;
    }
  }

  @override
  Future<List<FeedItem>> fetchMorePosts(PostType postType, int page) async {
    switch (postType) {
      case PostType.top:
        final feed = await client.news(page: page);

        return feed.items;

      case PostType.ask:
        final feed = await client.ask(page: page);

        return feed.items;

      case PostType.show:
        final feed = await client.show(page: page);

        return feed.items;

      case PostType.job:
        // TODO: Add page to jobs method
        final feed = await client.jobs();

        return feed.items;

      default:
        return null;
    }
  }

  @override
  Future<List<Item>> fetchComments(FeedItem post) async =>
      _fetchItems([], 0, [].length);

  Future<List<Item>> _fetchItems(List<dynamic> ids, int from, int to) async {
    List<Item> posts = [];

    // for (var i = from; i < to; ++i) {
    //   if (i >= ids.length) break;

    //   final response = await dio.get('$apiUrl/item/${ids[i]}.json');

    //   if (response.data == null) continue; // Post deleted?

    //   if (response.statusCode == 200) {
    //     final post = Post.fromJson(response.data);
    //     post.index = i + 1;

    //     posts.add(post);
    //   }
    // }

    return posts;
  }
}

class NetworkError extends Error {}

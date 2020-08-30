import 'package:fhn/data/models/post.dart';
import 'package:fhn/widgets/post_item.dart';
import 'package:flutter/material.dart';

class PostListUtils {
  static Widget buildInitialState(context) {
    return Center(child: Text('Preparing to load posts'));
  }

  static Widget buildLoadingState() =>
      Center(child: CircularProgressIndicator());

  static Widget buildLoadedState(
          BuildContext context, List<Post> posts, bool isLoadingMore) =>
      posts.length == 0
          ? Center(child: Text('No posts found'))
          : Column(
              children: <Widget>[
                Column(
                  children: posts
                      .map(
                        (post) => Column(
                          children: <Widget>[
                            Divider(
                              height: 24,
                              color: Theme.of(context).dividerColor,
                            ),
                            PostItem(post),
                          ],
                        ),
                      )
                      .toList(),
                ),
                !isLoadingMore ? Container() : CircularProgressIndicator(),
              ],
            );

  static Widget buildErrorState(context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Error loading posts:'),
          Text(message),
        ],
      ),
    );
  }
}

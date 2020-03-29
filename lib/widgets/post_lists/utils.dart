import 'package:fhn/data/models/post.dart';
import 'package:fhn/widgets/post_item.dart';
import 'package:flutter/material.dart';

class PostListUtils {
  static Widget buildInitialState(context) {
    return Center(child: Text('Preparing to load posts'));
  }

  static Widget buildLoadingState() => CircularProgressIndicator();

  static Widget buildLoadedState(BuildContext context, List<Post> posts) =>
      posts.length == 0
          ? Center(child: Text('No posts found'))
          : Column(
              children: posts
                  .map(
                    (post) => PostItem(post),
                  )
                  .toList(),
            );

  static Widget buildErrorState(context) {
    return Center(child: Text('Error loading posts'));
  }

  static void showError(BuildContext context, dynamic state) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(state.message),
      ),
    );
  }
}

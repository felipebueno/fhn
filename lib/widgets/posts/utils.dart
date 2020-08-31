import 'package:fhn/widgets/post_item.dart';
import 'package:flutter/material.dart';
import 'package:hnpwa_client/hnpwa_client.dart';

class PostListUtils {
  static Widget buildInitialState(context) {
    return Center(child: Text('Preparing to load posts'));
  }

  static Widget buildLoadingState() =>
      Center(child: CircularProgressIndicator());

  static Widget buildLoadedState(
      BuildContext context, List<FeedItem> posts, bool isLoadingMore,
      {bool isJobPage = false}) {
    return posts == null || posts.length == 0
        ? Center(child: Text('No posts found'))
        : Column(
            children: <Widget>[
              Column(
                children: posts
                    .asMap()
                    .entries
                    .map(
                      (post) => Column(
                        children: <Widget>[
                          Divider(
                            height: 24,
                            color: Theme.of(context).buttonColor,
                          ),
                          PostItem(
                            post.key + 1,
                            post.value,
                            isJobPage: isJobPage,
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
              !isLoadingMore ? Container() : CircularProgressIndicator(),
            ],
          );
  }

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

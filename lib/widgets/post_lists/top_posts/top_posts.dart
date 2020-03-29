import 'package:fhn/data/models/post.dart';
import 'package:fhn/data/repository.dart';
import 'package:fhn/widgets/base_bloc_consumer.dart';
import 'package:fhn/widgets/post_item.dart';
import 'package:fhn/widgets/post_lists/top_posts/top_posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopPosts extends StatelessWidget {
  const TopPosts({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<TopPostsBloc, TopPostsState>(
      onReady: () =>
          BlocProvider.of<TopPostsBloc>(context).add(GetPosts(PostType.top)),
      listener: (context, state) {
        if (state is TopPostsError) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is TopPostsInitial) {
          return _buildInitial(context);
        } else if (state is TopPostsLoading) {
          return _buildLoading();
        } else if (state is TopPostsLoaded) {
          return _buildLoaded(context, state.posts);
        } else if (state is TopPostsError) {
          return _buildInitial(context);
        }
        return Container();
      },
    );
  }

  Widget _buildInitial(context) {
    return Center(child: Text('Preparing to load posts'));
  }

  Widget _buildLoading() => CircularProgressIndicator();

  Widget _buildLoaded(BuildContext context, List<Post> posts) =>
      posts.length == 0
          ? Center(child: Text('No posts found :('))
          : Column(
        children: posts
            .map(
              (post) => PostItem(post),
        )
            .toList(),
      );
}

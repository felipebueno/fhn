import 'package:fhn/data/models/post.dart';
import 'package:fhn/data/repository.dart';
import 'package:fhn/widgets/base_bloc_consumer.dart';
import 'package:fhn/widgets/post_item.dart';
import 'package:fhn/widgets/post_lists/ask_posts/ask_posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AskPosts extends StatelessWidget {
  const AskPosts({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<AskPostsBloc, AskPostsState>(
      onReady: () =>
          BlocProvider.of<AskPostsBloc>(context).add(GetPosts(PostType.ask)),
      listener: (context, state) {
        if (state is AskPostsError) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AskPostsInitial) {
          return _buildInitial(context);
        } else if (state is AskPostsLoading) {
          return _buildLoading();
        } else if (state is AskPostsLoaded) {
          return _buildLoaded(context, state.posts);
        } else if (state is AskPostsError) {
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

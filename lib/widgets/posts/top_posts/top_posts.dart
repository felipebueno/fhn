import 'package:fhn/data/models/post.dart';
import 'package:fhn/utils.dart';
import 'package:fhn/widgets/base_bloc_consumer.dart';
import 'package:fhn/widgets/posts/top_posts/top_posts_bloc.dart';
import 'package:fhn/widgets/posts/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopPosts extends StatelessWidget {
  const TopPosts({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Post> posts;

    return BaseBlocConsumer<TopPostsBloc, TopPostsState>(
      onReady: () => BlocProvider.of<TopPostsBloc>(context).add(GetTopPosts()),
      listener: (context, state) {
        if (state is TopPostsError) {
          Utils.showInfo(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is TopPostsInitial) {
          return PostListUtils.buildInitialState(context);
        } else if (state is TopPostsLoading) {
          return PostListUtils.buildLoadingState();
        } else if (state is TopPostsLoaded) {
          posts = state.posts;
          return PostListUtils.buildLoadedState(context, posts, false);
        } else if (state is TopPostsError) {
          return PostListUtils.buildErrorState(context, state.message);
        } else if (state is TopPostsLoadingMore) {
          return PostListUtils.buildLoadedState(context, posts, true);
        }
        return Container();
      },
    );
  }
}

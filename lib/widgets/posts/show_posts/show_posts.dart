import 'package:fhn/utils.dart';
import 'package:fhn/widgets/base_bloc_consumer.dart';
import 'package:fhn/widgets/posts/show_posts/show_posts_bloc.dart';
import 'package:fhn/widgets/posts/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hnpwa_client/hnpwa_client.dart';

class ShowPosts extends StatelessWidget {
  const ShowPosts({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<FeedItem> posts;

    return BaseBlocConsumer<ShowPostsBloc, ShowPostsState>(
      onReady: () =>
          BlocProvider.of<ShowPostsBloc>(context).add(GetShowPosts()),
      listener: (context, state) {
        if (state is ShowPostsError) {
          Utils.showInfo(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is ShowPostsInitial) {
          return PostListUtils.buildInitialState(context);
        } else if (state is ShowPostsLoading) {
          return PostListUtils.buildLoadingState();
        } else if (state is ShowPostsLoaded) {
          posts = state.posts;
          return PostListUtils.buildLoadedState(context, posts, false);
        } else if (state is ShowPostsError) {
          return PostListUtils.buildErrorState(context, state.message);
        } else if (state is ShowPostsLoadingMore) {
          return PostListUtils.buildLoadedState(context, posts, true);
        }
        return Container();
      },
    );
  }
}

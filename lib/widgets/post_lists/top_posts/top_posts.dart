import 'package:fhn/data/repository.dart';
import 'package:fhn/widgets/base_bloc_consumer.dart';
import 'package:fhn/widgets/post_lists/top_posts/top_posts_bloc.dart';
import 'package:fhn/widgets/post_lists/utils.dart';
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
          PostListUtils.showError(context, state);
        }
      },
      builder: (context, state) {
        if (state is TopPostsInitial) {
          return PostListUtils.buildInitialState(context);
        } else if (state is TopPostsLoading) {
          return PostListUtils.buildLoadingState();
        } else if (state is TopPostsLoaded) {
          return PostListUtils.buildLoadedState(context, state.posts);
        } else if (state is TopPostsError) {
          return PostListUtils.buildInitialState(context);
        }
        return Container();
      },
    );
  }
}

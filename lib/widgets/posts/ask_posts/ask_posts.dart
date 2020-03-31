import 'package:fhn/utils.dart';
import 'package:fhn/widgets/base_bloc_consumer.dart';
import 'package:fhn/widgets/posts/ask_posts/ask_posts_bloc.dart';
import 'package:fhn/widgets/posts/utils.dart';
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
          BlocProvider.of<AskPostsBloc>(context).add(GetAskPosts()),
      listener: (context, state) {
        if (state is AskPostsError) {
          Utils.showInfo(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is AskPostsInitial) {
          return PostListUtils.buildInitialState(context);
        } else if (state is AskPostsLoading) {
          return PostListUtils.buildLoadingState();
        } else if (state is AskPostsLoaded) {
          return PostListUtils.buildLoadedState(context, state.posts);
        } else if (state is AskPostsError) {
          return PostListUtils.buildErrorState(context, state.message);
        }
        return Container();
      },
    );
  }
}

import 'package:fhn/data/models/post.dart';
import 'package:fhn/utils.dart';
import 'package:fhn/widgets/base_bloc_consumer.dart';
import 'package:fhn/widgets/posts/job_posts/job_posts_bloc.dart';
import 'package:fhn/widgets/posts/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobPosts extends StatelessWidget {
  const JobPosts({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Post> posts;

    return BaseBlocConsumer<JobPostsBloc, JobPostsState>(
      onReady: () => BlocProvider.of<JobPostsBloc>(context).add(GetJobPosts()),
      listener: (context, state) {
        if (state is JobPostsError) {
          Utils.showInfo(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is JobPostsInitial) {
          return PostListUtils.buildInitialState(context);
        } else if (state is JobPostsLoading) {
          return PostListUtils.buildLoadingState();
        } else if (state is JobPostsLoaded) {
          posts = state.posts;
          return PostListUtils.buildLoadedState(context, posts, false);
        } else if (state is JobPostsError) {
          return PostListUtils.buildErrorState(context, state.message);
        } else if (state is JobPostsLoadingMore) {
          return PostListUtils.buildLoadedState(context, posts, true);
        }
        return Container();
      },
    );
  }
}

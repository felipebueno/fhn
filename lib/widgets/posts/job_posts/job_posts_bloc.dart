import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fhn/data/post_repository.dart';
import 'package:hnpwa_client/hnpwa_client.dart';

part 'job_posts_event.dart';
part 'job_posts_state.dart';

class JobPostsBloc extends Bloc<JobPostsEvent, JobPostsState> {
  final IPostRepository postRepository;
  List<FeedItem> posts;
  int page = 1;

  JobPostsBloc(JobPostsState initialState, this.postRepository)
      : super(initialState);

  @override
  Stream<JobPostsState> mapEventToState(
    JobPostsEvent event,
  ) async* {
    if (event is GetJobPosts) {
      yield JobPostsLoading();

      page = 1;

      try {
        posts = await postRepository.fetchPosts(PostType.job);
        yield JobPostsLoaded(posts);
      } on NetworkError {
        yield JobPostsError(
            "Couldn't fetch posts. Make sure your device is connected to the internet.");
      } catch (e) {
        yield JobPostsError(e.toString());
      }
    } else if (event is GetMoreJobPosts) {
      yield JobPostsLoadingMore();

      try {
        final List<FeedItem> newPosts =
            await postRepository.fetchMorePosts(PostType.job, ++page);

        final List<FeedItem> morePosts =
            List<FeedItem>.from(JobPostsLoaded(posts).posts)..addAll(newPosts);

        posts = morePosts;

        yield JobPostsLoaded(posts);
      } on NetworkError {
        yield JobPostsError(
            "Couldn't fetch more show posts. Make sure your device is connected to the internet.");
      } catch (e) {
        yield JobPostsError(e.toString());
      }
    }
  }
}

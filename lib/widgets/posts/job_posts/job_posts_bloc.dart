import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fhn/data/models/post.dart';
import 'package:fhn/data/post_repository.dart';

part 'job_posts_event.dart';
part 'job_posts_state.dart';

class JobPostsBloc extends Bloc<JobPostsEvent, JobPostsState> {
  final PostRepository postRepository;
  List<Post> posts;
  int from = 30;
  int to = 60;

  JobPostsBloc(this.postRepository);

  @override
  JobPostsState get initialState => JobPostsInitial();

  @override
  Stream<JobPostsState> mapEventToState(
    JobPostsEvent event,
  ) async* {
    if (event is GetJobPosts) {
      yield JobPostsLoading();

      from = 30;
      to = 60;

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
        final List<Post> newPosts =
            await postRepository.fetchMorePosts(PostType.job, from, to);

        final List<Post> morePosts =
            List<Post>.from(JobPostsLoaded(posts).posts)..addAll(newPosts);

        posts = morePosts;

        from += 30;
        to += 30;

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

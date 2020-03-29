import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fhn/data/models/post.dart';
import 'package:fhn/data/repository.dart';

part 'job_posts_event.dart';

part 'job_posts_state.dart';

class JobPostsBloc extends Bloc<JobPostsEvent, JobPostsState> {
  final PostRepository postRepository;

  JobPostsBloc(this.postRepository);

  @override
  JobPostsState get initialState => JobPostsInitial();

  @override
  Stream<JobPostsState> mapEventToState(
    JobPostsEvent event,
  ) async* {
    yield JobPostsLoading();
    if (event is GetPosts) {
      try {
        final posts = await postRepository.fetchPosts(event.postType);
        yield JobPostsLoaded(posts);
      } on NetworkError {
        yield JobPostsError(
            "Couldn't fetch posts. Make sure your device is connected to the internet.");
      }
    }
  }
}

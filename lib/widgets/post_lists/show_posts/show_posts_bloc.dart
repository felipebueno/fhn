import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fhn/data/models/post.dart';
import 'package:fhn/data/repository.dart';

part 'show_posts_event.dart';

part 'show_posts_state.dart';

class ShowPostsBloc extends Bloc<ShowPostsEvent, ShowPostsState> {
  final PostRepository postRepository;

  ShowPostsBloc(this.postRepository);

  @override
  ShowPostsState get initialState => ShowPostsInitial();

  @override
  Stream<ShowPostsState> mapEventToState(
    ShowPostsEvent event,
  ) async* {
    yield ShowPostsLoading();
    if (event is GetPosts) {
      try {
        final posts = await postRepository.fetchPosts(event.postType);
        yield ShowPostsLoaded(posts);
      } on NetworkError {
        yield ShowPostsError(
            "Couldn't fetch posts. Make sure your device is connected to the internet.");
      }
    }
  }
}

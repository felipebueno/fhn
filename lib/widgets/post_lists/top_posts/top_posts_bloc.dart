import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fhn/data/models/post.dart';
import 'package:fhn/data/post_repository.dart';

part 'top_posts_event.dart';
part 'top_posts_state.dart';

class TopPostsBloc extends Bloc<TopPostsEvent, TopPostsState> {
  final PostRepository postRepository;

  TopPostsBloc(this.postRepository);

  @override
  TopPostsState get initialState => TopPostsInitial();

  @override
  Stream<TopPostsState> mapEventToState(TopPostsEvent event,) async* {
    yield TopPostsLoading();
    if (event is GetPosts) {
      try {
        final posts = await postRepository.fetchPosts(event.postType);
        yield TopPostsLoaded(posts);
      } on NetworkError {
        yield TopPostsError(
            "Couldn't fetch posts. Make sure your device is connected to the internet.");
      } catch (e) {
        yield TopPostsError(e.toString());
      }
    }
  }
}

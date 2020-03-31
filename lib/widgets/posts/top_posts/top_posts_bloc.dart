import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fhn/data/models/post.dart';
import 'package:fhn/data/post_repository.dart';

part 'top_posts_event.dart';
part 'top_posts_state.dart';

class TopPostsBloc extends Bloc<TopPostsEvent, TopPostsState> {
  final PostRepository postRepository;
  List<Post> posts;

  TopPostsBloc(this.postRepository);

  int from = 30;
  int to = 60;

  @override
  TopPostsState get initialState => TopPostsInitial();

  @override
  Stream<TopPostsState> mapEventToState(TopPostsEvent event,) async* {
    if (event is GetTopPosts) {
      yield TopPostsLoading();

      from = 30;
      to = 60;

      try {
        posts = await postRepository.fetchPosts(PostType.top);
        yield TopPostsLoaded(posts);
      } on NetworkError {
        yield TopPostsError(
            "Couldn't fetch posts. Make sure your device is connected to the internet.");
      } catch (e) {
        yield TopPostsError(e.toString());
      }
    } else if (event is GetMoreTopPosts) {
//      yield TopPostsLoadingMore();

      try {
        final List<Post> newPosts =
        await postRepository.fetchMorePosts(PostType.top, from, to);

        final List<Post> morePosts =
        List<Post>.from(TopPostsLoaded(posts).posts)
          ..addAll(newPosts);

        posts = morePosts;

        from += 30;
        to += 30;

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

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fhn/data/models/post.dart';
import 'package:fhn/data/post_repository.dart';

part 'show_posts_event.dart';
part 'show_posts_state.dart';

class ShowPostsBloc extends Bloc<ShowPostsEvent, ShowPostsState> {
  final PostRepository postRepository;
  List<Post> posts;
  int from = 30;
  int to = 60;

  ShowPostsBloc(ShowPostsState initialState, this.postRepository)
      : super(initialState);

  @override
  Stream<ShowPostsState> mapEventToState(
    ShowPostsEvent event,
  ) async* {
    if (event is GetShowPosts) {
      yield ShowPostsLoading();

      from = 30;
      to = 60;

      try {
        posts = await postRepository.fetchPosts(PostType.show);
        yield ShowPostsLoaded(posts);
      } on NetworkError {
        yield ShowPostsError(
            "Couldn't fetch show posts. Make sure your device is connected to the internet.");
      } catch (e) {
        yield ShowPostsError(e.toString());
      }
    } else if (event is GetMoreShowPosts) {
      yield ShowPostsLoadingMore();

      try {
        final List<Post> newPosts =
            await postRepository.fetchMorePosts(PostType.show, from, to);

        final List<Post> morePosts =
            List<Post>.from(ShowPostsLoaded(posts).posts)..addAll(newPosts);

        posts = morePosts;

        from += 30;
        to += 30;

        yield ShowPostsLoaded(posts);
      } on NetworkError {
        yield ShowPostsError(
            "Couldn't fetch more show posts. Make sure your device is connected to the internet.");
      } catch (e) {
        yield ShowPostsError(e.toString());
      }
    }
  }
}

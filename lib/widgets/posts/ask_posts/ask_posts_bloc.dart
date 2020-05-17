import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fhn/data/models/post.dart';
import 'package:fhn/data/post_repository.dart';

part 'ask_posts_event.dart';
part 'ask_posts_state.dart';

class AskPostsBloc extends Bloc<AskPostsEvent, AskPostsState> {
  final PostRepository postRepository;
  List<Post> posts;
  int from = 30;
  int to = 60;

  AskPostsBloc(this.postRepository);

  @override
  AskPostsState get initialState => AskPostsInitial();

  @override
  Stream<AskPostsState> mapEventToState(
    AskPostsEvent event,
  ) async* {
    if (event is GetAskPosts) {
      yield AskPostsLoading();

      from = 30;
      to = 60;

      try {
        posts = await postRepository.fetchPosts(PostType.ask);
        yield AskPostsLoaded(posts);
      } on NetworkError {
        yield AskPostsError(
            "Couldn't fetch ask posts. Make sure your device is connected to the internet.");
      } catch (e) {
        yield AskPostsError(e.toString());
      }
    } else if (event is GetMoreAskPosts) {
      yield AskPostsLoadingMore();

      try {
        final List<Post> newPosts =
            await postRepository.fetchMorePosts(PostType.ask, from, to);

        final List<Post> morePosts =
            List<Post>.from(AskPostsLoaded(posts).posts)..addAll(newPosts);

        posts = morePosts;

        from += 30;
        to += 30;

        yield AskPostsLoaded(posts);
      } on NetworkError {
        yield AskPostsError(
            "Couldn't fetch more ask posts. Make sure your device is connected to the internet.");
      } catch (e) {
        yield AskPostsError(e.toString());
      }
    }
  }
}

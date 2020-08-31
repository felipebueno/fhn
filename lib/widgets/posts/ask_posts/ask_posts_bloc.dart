import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fhn/data/post_repository.dart';
import 'package:hnpwa_client/hnpwa_client.dart';

part 'ask_posts_event.dart';
part 'ask_posts_state.dart';

class AskPostsBloc extends Bloc<AskPostsEvent, AskPostsState> {
  final IPostRepository postRepository;
  List<FeedItem> posts;
  int currentPage = 1;
  final int maxPage = 2;

  AskPostsBloc(AskPostsState initialState, this.postRepository)
      : super(initialState);

  @override
  Stream<AskPostsState> mapEventToState(
    AskPostsEvent event,
  ) async* {
    if (event is GetAskPosts) {
      yield AskPostsLoading();

      currentPage = 1;

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
      if (currentPage >= maxPage) return;

      yield AskPostsLoadingMore();

      try {
        final List<FeedItem> newPosts =
            await postRepository.fetchMorePosts(PostType.ask, ++currentPage);

        final List<FeedItem> morePosts =
            List<FeedItem>.from(AskPostsLoaded(posts).posts)..addAll(newPosts);

        posts = morePosts;

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

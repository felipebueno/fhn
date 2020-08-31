import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fhn/data/post_repository.dart';
import 'package:hnpwa_client/hnpwa_client.dart';

part 'top_posts_event.dart';
part 'top_posts_state.dart';

class TopPostsBloc extends Bloc<TopPostsEvent, TopPostsState> {
  final IPostRepository postRepository;
  List<FeedItem> posts;
  int currentPage = 1;
  int maxPage = 10;

  TopPostsBloc(TopPostsState initialState, this.postRepository)
      : super(initialState);

  @override
  Stream<TopPostsState> mapEventToState(
    TopPostsEvent event,
  ) async* {
    if (event is GetTopPosts) {
      yield TopPostsLoading();

      currentPage = 1;

      try {
        posts = await postRepository.fetchPosts(PostType.top);
        yield TopPostsLoaded(posts);
      } on NetworkError {
        yield TopPostsError(
            "Couldn't fetch top posts. Make sure your device is connected to the internet.");
      } catch (e) {
        yield TopPostsError(e.toString());
      }
    } else if (event is GetMoreTopPosts) {
      if (currentPage >= maxPage) return;

      yield TopPostsLoadingMore();

      try {
        final List<FeedItem> newPosts =
            await postRepository.fetchMorePosts(PostType.top, ++currentPage);

        final List<FeedItem> morePosts =
            List<FeedItem>.from(TopPostsLoaded(posts).posts)..addAll(newPosts);

        posts = morePosts;

        yield TopPostsLoaded(posts);
      } on NetworkError {
        yield TopPostsError(
            "Couldn't fetch more top posts. Make sure your device is connected to the internet.");
      } catch (e) {
        yield TopPostsError(e.toString());
      }
    }
  }
}

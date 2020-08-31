import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fhn/data/post_repository.dart';
import 'package:hnpwa_client/hnpwa_client.dart';

part 'show_posts_event.dart';
part 'show_posts_state.dart';

class ShowPostsBloc extends Bloc<ShowPostsEvent, ShowPostsState> {
  final IPostRepository postRepository;
  List<FeedItem> posts;
  int currentPage = 1;
  final int maxPage = 2;

  ShowPostsBloc(ShowPostsState initialState, this.postRepository)
      : super(initialState);

  @override
  Stream<ShowPostsState> mapEventToState(
    ShowPostsEvent event,
  ) async* {
    if (event is GetShowPosts) {
      yield ShowPostsLoading();

      currentPage = 1;

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
      if (currentPage >= maxPage) return;

      yield ShowPostsLoadingMore();

      try {
        final List<FeedItem> newPosts =
            await postRepository.fetchMorePosts(PostType.show, ++currentPage);

        final List<FeedItem> morePosts =
            List<FeedItem>.from(ShowPostsLoaded(posts).posts)..addAll(newPosts);

        posts = morePosts;

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

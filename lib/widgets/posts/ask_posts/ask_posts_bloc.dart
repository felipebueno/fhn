import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fhn/data/models/post.dart';
import 'package:fhn/data/post_repository.dart';

part 'ask_posts_event.dart';
part 'ask_posts_state.dart';

class AskPostsBloc extends Bloc<AskPostsEvent, AskPostsState> {
  final PostRepository postRepository;

  AskPostsBloc(this.postRepository);

  @override
  AskPostsState get initialState => AskPostsInitial();

  @override
  Stream<AskPostsState> mapEventToState(
    AskPostsEvent event,
  ) async* {
    yield AskPostsLoading();
    if (event is GetAskPosts) {
      try {
        final posts = await postRepository.fetchPosts(PostType.ask);
        yield AskPostsLoaded(posts);
      } on NetworkError {
        yield AskPostsError(
            "Couldn't fetch posts. Make sure your device is connected to the internet.");
      } catch (e) {
        yield AskPostsError(e.toString());
      }
    }
  }
}

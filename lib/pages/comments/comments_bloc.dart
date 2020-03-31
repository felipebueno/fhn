import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fhn/data/models/post.dart';
import 'package:fhn/data/post_repository.dart';

part 'comments_event.dart';

part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final PostRepository postRepository;

  CommentsBloc(this.postRepository);

  @override
  CommentsState get initialState => CommentsInitial();

  @override
  Stream<CommentsState> mapEventToState(
    CommentsEvent event,
  ) async* {
    yield CommentsLoading();
    if (event is GetComments) {
      try {
        final posts = await postRepository.fetchComments(event.post);
        yield CommentsLoaded(posts);
      } on NetworkError {
        yield CommentsError(
            "Couldn't fetch comments. Make sure your device is connected to the internet.");
      }
    }
  }
}

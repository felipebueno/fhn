import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fhn/data/post_repository.dart';
import 'package:hnpwa_client/hnpwa_client.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final IPostRepository postRepository;

  CommentsBloc(CommentsState initialState, this.postRepository)
      : super(initialState);

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

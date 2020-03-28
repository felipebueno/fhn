import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fhn/data/models/post.dart';
import 'package:fhn/data/repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PostRepository postRepository;

  HomeBloc(this.postRepository);

  @override
  HomeState get initialState => HomeInitial();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event,) async* {
    yield HomeLoading();
    if (event is GetPosts) {
      try {
        final posts = await postRepository.fetchPosts(event.postType);
        yield HomeLoaded(posts);
      } on NetworkError {
        yield HomeError(
            "Couldn't fetch posts. Make sure your device is connected to the internet.");
      }
    }
  }
}

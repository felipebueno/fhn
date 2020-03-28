part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetPosts extends HomeEvent {
  final PostType postType;

  const GetPosts(this.postType);

  @override
  List<Object> get props => [postType];
}

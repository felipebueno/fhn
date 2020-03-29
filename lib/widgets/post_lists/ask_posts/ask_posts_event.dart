part of 'ask_posts_bloc.dart';

abstract class AskPostsEvent extends Equatable {
  const AskPostsEvent();
}

class GetPosts extends AskPostsEvent {
  final PostType postType;

  const GetPosts(this.postType);

  @override
  List<Object> get props => [postType];
}

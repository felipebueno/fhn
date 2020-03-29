part of 'top_posts_bloc.dart';

abstract class TopPostsEvent extends Equatable {
  const TopPostsEvent();
}

class GetPosts extends TopPostsEvent {
  final PostType postType;

  const GetPosts(this.postType);

  @override
  List<Object> get props => [postType];
}

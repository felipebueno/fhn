part of 'show_posts_bloc.dart';

abstract class ShowPostsEvent extends Equatable {
  const ShowPostsEvent();
}

class GetPosts extends ShowPostsEvent {
  final PostType postType;

  const GetPosts(this.postType);

  @override
  List<Object> get props => [postType];
}

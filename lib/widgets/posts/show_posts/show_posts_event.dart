part of 'show_posts_bloc.dart';

abstract class ShowPostsEvent extends Equatable {
  const ShowPostsEvent();
}

class GetShowPosts extends ShowPostsEvent {
  const GetShowPosts();

  @override
  List<Object> get props => [];
}

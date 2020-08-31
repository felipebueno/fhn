part of 'comments_bloc.dart';

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();
}

class GetComments extends CommentsEvent {
  final FeedItem post;

  const GetComments(this.post);

  @override
  List<Object> get props => [post];
}

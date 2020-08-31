part of 'comments_bloc.dart';

abstract class CommentsState extends Equatable {
  const CommentsState();
}

class CommentsInitial extends CommentsState {
  @override
  List<Object> get props => [];
}

class CommentsLoading extends CommentsState {
  const CommentsLoading();

  @override
  List<Object> get props => [];
}

class CommentsLoaded extends CommentsState {
  final List<Item> comments;

  const CommentsLoaded(this.comments);

  @override
  List<Object> get props => [comments];
}

class CommentsError extends CommentsState {
  final String message;

  const CommentsError(this.message);

  @override
  List<Object> get props => [message];
}

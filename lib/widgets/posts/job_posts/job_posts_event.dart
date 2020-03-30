part of 'job_posts_bloc.dart';

abstract class JobPostsEvent extends Equatable {
  const JobPostsEvent();
}

class GetPosts extends JobPostsEvent {
  final PostType postType;

  const GetPosts(this.postType);

  @override
  List<Object> get props => [postType];
}

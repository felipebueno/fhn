import 'package:fhn/bloc/home/home_bloc.dart';
import 'package:fhn/data/models/post.dart';
import 'package:fhn/data/repository.dart';
import 'package:fhn/widgets/base_bloc_consumer.dart';
import 'package:fhn/widgets/post_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopPosts extends StatelessWidget {
  const TopPosts({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<HomeBloc, HomeState>(
      onReady: () =>
          BlocProvider.of<HomeBloc>(context).add(GetPosts(PostType.top)),
      listener: (context, state) {
        if (state is HomeError) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is HomeInitial) {
          return _buildInitial(context);
        } else if (state is HomeLoading) {
          return _buildLoading();
        } else if (state is HomeLoaded) {
          return _buildLoaded(context, state.posts);
        } else if (state is HomeError) {
          return _buildInitial(context);
        }
        return Container();
      },
    );
  }

  Widget _buildInitial(context) {
    return Center(child: Text('Preparing to load posts'));
  }

  Widget _buildLoading() => CircularProgressIndicator();

  Widget _buildLoaded(BuildContext context, List<Post> posts) =>
      posts.length == 0
          ? Center(child: Text('No posts found :('))
          : Column(
        children: posts
            .map(
              (post) => PostItem(post),
        )
            .toList(),
      );
}

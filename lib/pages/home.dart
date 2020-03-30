import 'package:fhn/constants.dart';
import 'package:fhn/data/post_repository.dart';
import 'package:fhn/widgets/base_tab.dart';
import 'package:fhn/widgets/post_lists/ask_posts/ask_posts.dart';
import 'package:fhn/widgets/post_lists/ask_posts/ask_posts_bloc.dart';
import 'package:fhn/widgets/post_lists/job_posts/job_posts.dart';
import 'package:fhn/widgets/post_lists/job_posts/job_posts_bloc.dart';
import 'package:fhn/widgets/post_lists/show_posts/show_posts.dart';
import 'package:fhn/widgets/post_lists/show_posts/show_posts_bloc.dart';
import 'package:fhn/widgets/post_lists/top_posts/top_posts.dart';
import 'package:fhn/widgets/post_lists/top_posts/top_posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  static const String id = 'home';

  final List<Tab> tabs = [
    Tab(icon: Icon(Icons.new_releases), text: "Top"),
    Tab(icon: Icon(Icons.question_answer), text: "Ask"),
    Tab(icon: Icon(Icons.show_chart), text: "Show"),
    Tab(icon: Icon(Icons.work), text: "Jobs"),
  ];

  final List<Widget> tabViews = [
    BaseTab(body: TopPosts()),
    BaseTab(body: AskPosts()),
    BaseTab(body: ShowPosts()),
    BaseTab(body: JobPosts()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kHNBGColor,
      body: DefaultTabController(
        length: this.tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: kHNOrange,
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    'Hacker News',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  background: Container(
                    color: kHNOrange,
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    indicatorColor: kHNOrange,
                    labelColor: kHNOrange,
                    unselectedLabelColor: kHNGrey,
                    tabs: this.tabs,
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => TopPostsBloc(RealPostRepository()),
              ),
              BlocProvider(
                create: (context) => AskPostsBloc(RealPostRepository()),
              ),
              BlocProvider(
                create: (context) => ShowPostsBloc(RealPostRepository()),
              ),
              BlocProvider(
                create: (context) => JobPostsBloc(RealPostRepository()),
              ),
            ],
            child: TabBarView(
              children: tabViews,
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  const _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context,
      double shrinkOffset,
      bool overlapsContent,) =>
      Material(
        color: kHNBGColor,
        child: _tabBar,
      );

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}

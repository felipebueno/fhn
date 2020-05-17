import 'package:fhn/data/post_repository.dart';
import 'package:fhn/widgets/base_tab.dart';
import 'package:fhn/widgets/posts/ask_posts/ask_posts.dart';
import 'package:fhn/widgets/posts/ask_posts/ask_posts_bloc.dart';
import 'package:fhn/widgets/posts/job_posts/job_posts.dart';
import 'package:fhn/widgets/posts/job_posts/job_posts_bloc.dart';
import 'package:fhn/widgets/posts/show_posts/show_posts.dart';
import 'package:fhn/widgets/posts/show_posts/show_posts_bloc.dart';
import 'package:fhn/widgets/posts/top_posts/top_posts.dart';
import 'package:fhn/widgets/posts/top_posts/top_posts_bloc.dart';
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
    BaseTab<TopPostsBloc>(
      body: TopPosts(),
      onRefresh: GetTopPosts(),
      onMoreTap: GetMoreTopPosts(),
    ),
    BaseTab<AskPostsBloc>(
      body: AskPosts(),
      onRefresh: GetAskPosts(),
      onMoreTap: GetMoreAskPosts(),
    ),
    BaseTab<ShowPostsBloc>(
      body: ShowPosts(),
      onRefresh: GetShowPosts(),
      onMoreTap: GetMoreShowPosts(),
    ),
    BaseTab<JobPostsBloc>(
      body: JobPosts(),
      onRefresh: GetJobPosts(),
      onMoreTap: GetMoreJobPosts(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
//    final bool isHNTheme = ThemeProvider.themeOf(context).id == 'hn_theme';

    return Scaffold(
      body: DefaultTabController(
        length: this.tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                actions: <Widget>[
//                  PopupMenuButton<String>(
//                    onCanceled: () {},
//                    onSelected: (value) {
//                      ThemeProvider.controllerOf(context).nextTheme();
//                    },
//                    itemBuilder: (BuildContext context) {
//                      return ['${isHNTheme ? 'Dark' : 'Light'} theme'].map((
//                          String choice) {
//                        return PopupMenuItem<String>(
//                          value: choice,
//                          child: IconText(
//                              icon: isHNTheme ? Icons.brightness_4 : Icons
//                                  .wb_sunny, text: choice),
//                        );
//                      }).toList();
//                    },
//                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    'Hacker News',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
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
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) =>
      Material(
        color: Theme
            .of(context)
            .backgroundColor,
        child: _tabBar,
      );

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}

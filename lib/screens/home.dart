import 'package:fhn/constants.dart';
import 'package:fhn/widgets/ask_posts.dart';
import 'package:fhn/widgets/base_tab.dart';
import 'package:fhn/widgets/job_posts.dart';
import 'package:fhn/widgets/show_posts.dart';
import 'package:fhn/widgets/top_posts.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  static const String id = 'home';

  final List<Tab> tabs = [
    Tab(icon: Icon(Icons.new_releases), text: "Top"),
    Tab(icon: Icon(Icons.question_answer), text: "Ask"),
    Tab(icon: Icon(Icons.show_chart), text: "Show"),
    Tab(icon: Icon(Icons.work), text: "Jobs"),
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
          body: TabBarView(
            children: <Widget>[
              BaseTab(body: TopPosts()),
              BaseTab(body: AskPosts()),
              BaseTab(body: ShowPosts()),
              BaseTab(body: JobPosts()),
            ],
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

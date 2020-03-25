import 'package:fhn/constants.dart';
import 'package:fhn/widgets/footer.dart';
import 'package:fhn/widgets/top_stories.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kHNBGColor,
      body: DefaultTabController(
        length: 5,
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
                    tabs: [
                      Tab(icon: Icon(Icons.new_releases), text: "Top"),
                      Tab(icon: Icon(Icons.question_answer), text: "Ask"),
                      Tab(icon: Icon(Icons.show_chart), text: "Show"),
                      Tab(icon: Icon(Icons.work), text: "Jobs"),
                      Tab(icon: Icon(Icons.search), text: "Search"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TopStories(),
                Footer(),
              ],
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

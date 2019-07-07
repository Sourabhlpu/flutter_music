import 'package:flutter/material.dart';
import 'ColoredTabBar.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('BOOZ'),
      centerTitle: true,
      leading: Icon(
        Icons.menu,
        color: Colors.white,
      ),
      actions: <Widget>[
        Icon(
          Icons.search,
          color: Colors.white,
        ),
        Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
      ],
      expandedHeight: 150,
      flexibleSpace: new CustomFlexibleSpaceBar(),
      bottom: ColoredTabBar(
        pink,
        TabBar(controller: _tabController, tabs: [
          Tab(
            text: 'Songs',
          ),
          Tab(
            text: 'Artists',
          ),
          Tab(
            text: 'Albums',
          ),
          Tab(
            text: 'Genres',
          ),
          Tab(
            text: 'Playlist',
          )
        ]),
      ),
    );
  }
}

class CustomFlexibleSpaceBar extends StatelessWidget {
  const CustomFlexibleSpaceBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      titlePadding: const EdgeInsets.only(left: 16, top: 30, bottom: 55),
      title: ValueListenableBuilder(
        valueListenable: scrollPercent,
        builder: (BuildContext context, double value, Widget widget) {
          return FractionalTranslation(
            translation: Offset(_calculateX(value), 0),
            child: Text(
              'Songs',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          );
        },
      ),
    );
  }
}

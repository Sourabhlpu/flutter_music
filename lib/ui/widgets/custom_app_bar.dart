import 'package:flutter/material.dart';
import 'package:flutter_music/ui/widgets/colored_tab_bar.dart';
import 'package:flutter_music/ui/shared/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  final ValueNotifier<double> animation;
  final List<Tab> tabs;
  final TabController tabController;

  CustomAppBar({
    @required this.animation,
    @required this.tabs,
    @required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('BOOZ'),
      centerTitle: true,
      leading: Icon(
        Icons.menu,
        color: Colors.white,
      ),
      actions: _getAppBarActions(),
      expandedHeight: 150,
      flexibleSpace: new CustomFlexibleSpaceBar(
        animation: animation,
      ),
      bottom: ColoredTabBar(
        pink,
        TabBar(
          controller: tabController,
          tabs: tabs,
        ),
      ),
    );
  }

  List<Widget> _getAppBarActions() {
    return List.generate(
      2,
      (int index) {
        return index == 0
            ? Icon(
                Icons.search,
                color: Colors.white,
              )
            : Icon(
                Icons.more_vert,
                color: Colors.white,
              );
      },
    );
  }
}

class CustomFlexibleSpaceBar extends StatelessWidget {
  final ValueNotifier<double> animation;
  const CustomFlexibleSpaceBar({
    Key key,
    @required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      titlePadding: const EdgeInsets.only(left: 16, top: 30, bottom: 55),
      title: ValueListenableBuilder(
        valueListenable: animation,
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

  double _calculateX(double scrollPercent) {
    scrollPercent = scrollPercent.clamp(0, 0.5);
    double percent;
    if (scrollPercent == 0)
      percent = 0;
    else
      percent = scrollPercent / 0.5;

    double x = -1.5 * percent;
    return x;
  }
}

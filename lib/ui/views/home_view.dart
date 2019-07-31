import 'package:flutter/material.dart';
import 'package:flutter_music/core/viewmodels/home_model.dart';
import 'package:flutter_music/ui/views/songs.dart';
import 'package:flutter_music/ui/widgets/CustomAppBar.dart';
import 'base_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;
  ValueNotifier<double> scrollPercent = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      onModelReady: (model) {
        model.initScrollController(_scrollController);
        model.initScrollPercent(scrollPercent);
      },
      builder: (context, model, child) => Scaffold(
            body: NotificationListener(
              onNotification: model.handleScrollNotification,
              child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      child: CustomAppBar(
                        animation: scrollPercent,
                        tabs: _getTabs(),
                        tabController: _tabController,
                      ),
                    )
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildTabs("songs"),
                    _buildTabs("artists"),
                    _buildTabs("albums"),
                    _buildTabs("genre"),
                    _buildTabs("playlist"),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  _buildTabs(String name) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return Songs(scrollPercent: scrollPercent, name: name);
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  List<Tab> _getTabs() {
    List<Tab> _tabs = [
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
    ];
    return _tabs;
  }
}

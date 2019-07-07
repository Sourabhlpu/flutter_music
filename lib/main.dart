import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_music/song.dart';
import 'app_colors.dart';
import 'package:flutter/rendering.dart';
import 'customwidgets/CustomAppBar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          primaryColor: primaryColor,
          accentColor: pink),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;
  ValueNotifier<double> scrollPercent = ValueNotifier(0);
  List<Song> songs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSongsList();
    _tabController = TabController(length: 5, vsync: this);
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      print(_scrollController.position.pixels);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          _updateScroll();
        } else if (notification is ScrollEndNotification) {
          _snapAppBar();
        }
      },
      child: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
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
    ));
  }

  _updateScroll() {
    double currentScrollPosition = _scrollController.position.pixels;
    currentScrollPosition = currentScrollPosition.clamp(0.0, 100.0);
    double currentScrollPercentOfAppBar = currentScrollPosition / 100.0;
    scrollPercent.value = currentScrollPercentOfAppBar;
  }

  _snapAppBar() {
    double currentPixelsScrolled = _scrollController.position.pixels;
    //snapping when in the range of 0 - 100
    if (currentPixelsScrolled < 30.0 && currentPixelsScrolled > 0.0) {
      _scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 100), curve: Curves.easeOut);
    } else if (currentPixelsScrolled >= 30 && currentPixelsScrolled < 100) {
      _scrollController.animateTo(100.0,
          duration: Duration(milliseconds: 100), curve: Curves.easeOut);
    }

    //snapping when in the range of 100 - 150
    else if (currentPixelsScrolled > 100 && currentPixelsScrolled < 125) {
      _scrollController.animateTo(100.0,
          duration: Duration(milliseconds: 100), curve: Curves.easeOut);
    } else if (currentPixelsScrolled >= 125 && currentPixelsScrolled < 150) {
      _scrollController.animateTo(150.0,
          duration: Duration(milliseconds: 100), curve: Curves.easeOut);
    }
  }

  _buildTabs(String name) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return CustomScrollView(
            key: PageStorageKey<String>(name),
            slivers: <Widget>[
              SliverOverlapInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return index == 0
                        ? buildTopRow()
                        : buildSongRow(songs[index]);
                  },
                  childCount: songs.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  buildTopRow() {
    return Stack(
      children: <Widget>[
        ValueListenableBuilder(
          valueListenable: scrollPercent,
          builder: (BuildContext context, double value, Widget child) {
            return Container(
              width: double.infinity,
              height: 50 * (1 - value),
              decoration: BoxDecoration(color: pink),
            );
          },
        ),
        buildSongRow(songs[0])
      ],
    );
  }

  buildSongRow(Song song) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        color: Theme.of(context).primaryColor,
        child: ListTile(
          leading: Icon(
            Icons.disc_full,
            color: Color(0xffe32a76),
          ),
          title: Text(
            song.name,
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
          subtitle: Text(
            '${song.name} . ${song.duration}',
            style: TextStyle(
                fontSize: 10,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
          trailing: IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () {}),
        ),
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

  _initSongsList() {
    songs.add(Song(name: "Fix you", artistName: "Coldplay", duration: "4.11"));
    songs.add(Song(
        name: "Kings & Queens",
        artistName: "30 Seconds To Mars",
        duration: "6.12"));
    songs.add(Song(name: "Pieces", artistName: "Sum 41", duration: "4.00"));
    songs.add(Song(
        name: "Carnival of Rust",
        artistName: "Poets of the Fall",
        duration: "3.41"));
    songs.add(Song(name: "Seether", artistName: "Broken", duration: "6.12"));
    songs.add(Song(
        name: "Breaking The Habbit",
        artistName: "Linkin Park",
        duration: "5.11"));
    songs
        .add(Song(name: "Hey Brother", artistName: "Avicii", duration: "5.00"));
    songs.add(Song(name: "Clocks", artistName: "Coldplay", duration: "3.11"));
    songs.add(Song(name: "For You", artistName: "Coldplay", duration: "4.11"));
    songs.add(Song(name: "Trouble", artistName: "Coldplay", duration: "4.16"));
    songs.add(Song(name: "Trouble", artistName: "Coldplay", duration: "4.16"));
    songs.add(Song(name: "Trouble", artistName: "Coldplay", duration: "4.16"));
    songs.add(Song(name: "Trouble", artistName: "Coldplay", duration: "4.16"));
    songs.add(Song(name: "Trouble", artistName: "Coldplay", duration: "4.16"));
    songs.add(Song(name: "Trouble", artistName: "Coldplay", duration: "4.16"));
    songs.add(Song(name: "Trouble", artistName: "Coldplay", duration: "4.16"));
    songs.add(Song(name: "Trouble", artistName: "Coldplay", duration: "4.16"));
    songs.add(Song(name: "Trouble", artistName: "Coldplay", duration: "4.16"));

    return songs;
  }
}

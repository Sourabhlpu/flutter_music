import 'package:flutter/material.dart';
import 'package:flutter_music/song.dart';
import 'app_colors.dart';
import 'package:flutter/rendering.dart';

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

  List<Song> songs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 5, vsync: this);

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
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
            flexibleSpace: FlexibleSpaceBar(
              titlePadding:
                  const EdgeInsets.only(left: 16, top: 30, bottom: 55),
              title: Text(
                'Songs',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
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
          ),
          SliverToBoxAdapter(
              child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(color: pink),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: 
                Transform(
                  transform: Matrix4.translationValues(0, -50, 0),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                    return buildSongRow(songs[index]);
                  }, itemCount: songs.length,),
                ),
              )
            ],
          )),
/*          SliverPadding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 25),
            sliver: SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return buildSongRow(songs[index]);
              }, childCount: songs.length),
            ),
          )*/
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();

  }

  buildSongRow(Song song) {
    return Container(
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
    );
  }
}

class ColoredTabBar extends Container implements PreferredSizeWidget {
  ColoredTabBar(this.color, this.tabBar);

  final Color color;
  final TabBar tabBar;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) => Container(
        color: color,
        child: tabBar,
      );
}

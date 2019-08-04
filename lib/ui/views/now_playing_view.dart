import 'package:flutter/material.dart';
import 'package:flutter_music/ui/shared/app_colors.dart';
import 'package:flutter_music/ui/widgets/song_controls.dart';
import 'package:flutter_music/ui/widgets/vinyl_seekbar.dart';

class NowPlaying extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: Text('Now Playing'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: double.infinity),
            VinylSeekbar(),
            SizedBox(height: 12),
            SongControls(title: 'Magic', album: 'Ghost Stories'),
            buildHeading("UP NEXT", 10),
            SongTile(
              title: 'Magic',
              image: 'images/album_art.jpg',
              album: 'Ghost Stories',
            ),
            buildHeading("PREVIOUS", 0),
            SongTile(
              title: 'Magic',
              image: 'images/album_art.jpg',
              album: 'Ghost Stories',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeading(String title, double topPadding) {
    return Padding(
      padding: EdgeInsets.only(
        top: topPadding,
        left: 40,
        right: 40,
        bottom: 2,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[600],
              width: 0.3,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 2.0),
            ),
          ],
        ),
      ),
    );
  }
}

class SongTile extends StatelessWidget {
  final String title;
  final String image;
  final String album;
  const SongTile({
    this.title,
    this.image,
    this.album,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(image),
        ),
        title: Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              letterSpacing: 1.5,
              fontSize: 14),
        ),
        subtitle: Text(
          album,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              letterSpacing: 1.5,
              fontSize: 10),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.play_arrow,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}

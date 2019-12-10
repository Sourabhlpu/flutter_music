import 'package:flutter/material.dart';
import 'package:flutter_music/core/enums/viewstate.dart';
import 'package:flutter_music/core/viewmodels/now_playing_model.dart';
import 'package:provider/provider.dart';

class SongControls extends StatelessWidget {
  final String title;
  final String album;

  SongControls({this.title, this.album});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    NowPlayingModel model = Provider.of<NowPlayingModel>(context);
    return Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(
          height: 4.0,
        ),
        Text(
          album,
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.skip_previous,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16.0),
            IconButton(
              iconSize: 50,
              icon: model.state == ViewState.Playing
                  ? Icon(
                      Icons.pause,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
              onPressed: () {
                model.onPlayPauseClicked();
              },
            ),
            SizedBox(width: 16.0),
            IconButton(
              icon: Icon(
                Icons.skip_next,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

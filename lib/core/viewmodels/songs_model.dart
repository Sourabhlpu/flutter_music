import 'dart:async';
import 'dart:collection';

import 'package:flutter_music/core/enums/viewstate.dart';
import 'package:flutter_music/core/services/fetch_songs.dart';
import 'package:songs_meta/song.dart';
import '../../locator.dart';
import 'base_model.dart';

class SongsModel extends BaseModel {
  var songService = locator<FetchSongsService>();

  HashMap<String, List<Song>> songs;

  Future getSongs() async {
    setState(ViewState.Busy);
    songs = await songService.fetchSongs();
    setState(ViewState.Idle);
  }

  String formatSongDuration(Song song) {
    int duration = int.parse(song.duration);
    double d = duration / 60000;
    return d.toStringAsFixed(2);
  }

  int getIndexedListSize() {
    return songs.length + songs.values.length;
  }
}

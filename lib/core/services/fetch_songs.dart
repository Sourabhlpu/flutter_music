import 'dart:async';
import 'dart:collection';

import 'package:songs_meta/song.dart';
import 'package:songs_meta/songs_meta.dart';

class FetchSongsService {
  StreamController<List<Song>> songsController = StreamController<List<Song>>();

  Future<HashMap<String, List<Song>>> fetchSongs() async {
    List<Song> songs = await SongsMeta.songsList;
    songsController.add(songs);
    return _convertSongListToMap(songs);
  }

  HashMap<String, List<Song>> _convertSongListToMap(List<Song> songs) {
    HashMap<String, List<Song>> map = HashMap();
    for (var value in songs) {
      String index = value.title.substring(0, 1);
      map.putIfAbsent(index, () => [])..add(value);
    }
    return map;
  }
}

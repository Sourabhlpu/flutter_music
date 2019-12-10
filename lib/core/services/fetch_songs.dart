import 'dart:async';

import 'package:songs_meta/song.dart';
import 'package:songs_meta/songs_meta.dart';

class FetchSongsService {
  StreamController<List<Song>> songsController = StreamController<List<Song>>();

  Future<List<Song>> fetchSongs() async {
    List<Song> songs = await SongsMeta.songsList;
    songs.sort((a, b) {
      return a.title.toLowerCase().compareTo(b.title.toLowerCase());
    });
    songsController.add(songs);
    return songs;
  }
}

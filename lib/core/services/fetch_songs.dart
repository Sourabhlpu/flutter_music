import 'package:songs_meta/song.dart';
import 'package:songs_meta/songs_meta.dart';

class FetchSongsService {
  Future<List<Song>> fetchSongs() async {
    List<Song> songs = await SongsMeta.songsList;
    return songs;
  }
}

import 'package:songs_meta/song.dart';

import '../../locator.dart';
import 'base_model.dart';
import '../services/audio_playback_service.dart';

class NowPlayingModel extends BaseModel {
  AudioPlaybackService audioPlaybackService;

  void initPlayer(Song song, List<Song> songs) {
    audioPlaybackService = locator<AudioPlaybackService>();
    audioPlaybackService.initPlayer(song, songs);
  }

  void onPlayPauseClicked() {
    audioPlaybackService.togglePlay();
  }

  void releasePlayer() {
    audioPlaybackService.releasePlayer();
  }
}

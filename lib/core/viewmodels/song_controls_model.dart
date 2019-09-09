import 'package:audioplayers/audioplayers.dart';

import 'base_model.dart';
import '../../locator.dart';

class SongControlsModel extends BaseModel {
  void onPlayPauseClicked() {
    AudioPlayer player = locator.get<AudioPlayer>();
    player.onPlayerStateChanged.listen((AudioPlayerState s) {
      if (s == AudioPlayerState.PLAYING)
        player.pause();
      else if (s == AudioPlayerState.PAUSED) player.resume();
    });
  }
}

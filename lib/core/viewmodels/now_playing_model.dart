import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_music/core/enums/viewstate.dart';
import 'package:songs_meta/song.dart';

import '../../locator.dart';
import 'base_model.dart';

class NowPlayingModel extends BaseModel {
  AudioPlayer player = locator.get<AudioPlayer>();

  void playSong(Song song) {
    player.play(song.path);

    player.onPlayerStateChanged.listen((state) {
      if (state == AudioPlayerState.PLAYING)
        setState(ViewState.Playing);
      else if (state == AudioPlayerState.PAUSED) setState(ViewState.Pause);
    });
  }

  void onPlayPauseClicked() {
    if (state == ViewState.Playing)
      player.pause();
    else if (state == ViewState.Pause) player.resume();
  }

  void releasePlayer() {
    player.release();
  }
}

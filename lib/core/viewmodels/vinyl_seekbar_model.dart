import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_music/core/viewmodels/base_model.dart';
import 'package:flutter_music/ui/shared/radial_drag.dart';
import 'package:songs_meta/song.dart';

import '../../locator.dart';

class VinylSeekbarModel extends BaseModel {
  AudioPlayer audioPlayer = locator.get<AudioPlayer>();
  double progressPercent = 0.0;
  Duration maxDuration;
  Duration currentDuration;
  Song song;
  bool isDragging = false;

  handleDrags(PolarCoord polarCoordinates) {
    isDragging = true;
    var angle = (polarCoordinates.angle / (2 * pi)) * 360;
    angle = angle.abs().clamp(0.0, 180.0);
    progressPercent = 1 - angle / 180;
    notifyListeners();
  }

  initModel(Song song) {
    this.song = song;
    _setMaxDuration();
    _listenToAudioPosition();
  }

  _setMaxDuration() {
    int duration = int.parse(song.duration);
    maxDuration = Duration(milliseconds: duration);
    audioPlayer.onDurationChanged.listen((Duration d) {
      print('Max duration: $d, $maxDuration');
    });
  }

  void _listenToAudioPosition() {
    audioPlayer.onAudioPositionChanged.listen((duration) {
      if (!isDragging)
        progressPercent = duration.inMilliseconds / maxDuration.inMilliseconds;
      currentDuration = duration;
      notifyListeners();
    });
  }

  String convertMilliSecondsToMMss(Duration duration) {
    if (duration == null) return "00:00";
    String minutes = duration.inMinutes.toString();
    int seconds = duration.inSeconds.remainder(60).toInt();
    String secondsString = seconds.toString().padLeft(2, "0");

    return "$minutes:$secondsString";
  }

  void handleDragEnd() {
    int currentDuraionOnDragging =
        (maxDuration.inMilliseconds * progressPercent).toInt();
    currentDuration = Duration(milliseconds: currentDuraionOnDragging);
    audioPlayer.seek(currentDuration).then((value) {
      isDragging = false;
    }, onError: (error) {
      print(error);
    });
    notifyListeners();
  }
}

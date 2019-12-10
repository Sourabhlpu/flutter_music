import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_music/core/enums/viewstate.dart';
import 'package:flutter_music/ui/shared/radial_drag.dart';
import 'package:songs_meta/song.dart';

import '../../locator.dart';

class AudioPlaybackService {
  Song _song;
  AudioPlayer _audioPlayer;
  AudioPlayerState _currentState;
  Duration _maxDuration;
  double _progressPercent;
  Duration _currentDuration;
  bool _isDragging = false;
  ViewState _repeatState;
  List<Song> _songs;

  StreamController<String> maxDurationController = StreamController<String>();
  StreamController<String> currentDurationController =
      StreamController<String>();
  StreamController<double> progressPercentController =
      StreamController<double>();

  get currentState => _currentState;
  set repeatState(state) => _repeatState = state;

  initPlayer(Song song, List<Song> songs) {
    _songs = songs;
    _audioPlayer = locator.get<AudioPlayer>();
    this._song = song;
    playSong();
    _listenPlayerState();
    _setMaxDuration();
    _listenToAudioPosition();
    _listenSongCompletion();
  }

  void playSong() {
    _audioPlayer.play(_song.path);
  }

  void togglePlay() {
    if (_currentState == AudioPlayerState.PAUSED)
      _audioPlayer.resume();
    else if (_currentState == AudioPlayerState.PLAYING) _audioPlayer.pause();
  }

  void _listenPlayerState() {
    _audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      _currentState = s;
    });
  }

  _setMaxDuration() {
    int duration = int.parse(_song.duration);
    _maxDuration = Duration(milliseconds: duration);
    maxDurationController.add(_convertMilliSecondsToMMss(_maxDuration));
    _audioPlayer.onDurationChanged.listen((Duration d) {});
  }

  handleDrags(PolarCoord polarCoordinates) {
    _isDragging = true;
    var angle = (polarCoordinates.angle / (2 * pi)) * 360;
    angle = angle.abs().clamp(0.0, 180.0);
    _progressPercent = 1 - angle / 180;
    progressPercentController.add(_progressPercent);
  }

  void handleDragEnd() {
    int currentTimeProgress =
        (_maxDuration.inMilliseconds * _progressPercent).toInt();
    _currentDuration = Duration(milliseconds: currentTimeProgress);
    currentDurationController.add(_convertMilliSecondsToMMss(_currentDuration));
    _audioPlayer.seek(_currentDuration).then((value) {
      _isDragging = false;
    });
  }

  void _listenToAudioPosition() {
    _audioPlayer.onAudioPositionChanged.listen((duration) {
      if (!_isDragging)
        _progressPercent =
            duration.inMilliseconds / _maxDuration.inMilliseconds;
      _currentDuration = duration;

      progressPercentController.add(_progressPercent);
      currentDurationController
          .add(_convertMilliSecondsToMMss(_currentDuration));
    });
  }

  void _listenSongCompletion() {
    _audioPlayer.onPlayerCompletion.listen((event) {
      if (_repeatState == ViewState.RepeatOne)
        _audioPlayer.play(_song.path);
      else if (_repeatState == ViewState.RepeatAll) {
        _repeatAllSongs();
      }
    });
  }

  void _repeatAllSongs() {
    int currentIndex = _songs.indexOf(_song);
    int lastIndex = _songs.length - 1;
    if (lastIndex == currentIndex)
      _audioPlayer.play(_songs[0].path);
    else
      _audioPlayer.play(_songs[currentIndex + 1].path);
  }

  String _convertMilliSecondsToMMss(Duration duration) {
    if (duration == null) return "00:00";
    String minutes = duration.inMinutes.toString();
    int seconds = duration.inSeconds.remainder(60).toInt();
    String secondsString = seconds.toString().padLeft(2, "0");

    return "$minutes:$secondsString";
  }

  void releasePlayer() {
    _audioPlayer.release();
  }
}

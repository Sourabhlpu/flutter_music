import 'package:flutter_music/core/enums/viewstate.dart';
import 'package:flutter_music/core/services/audio_playback_service.dart';
import 'package:flutter_music/core/viewmodels/base_model.dart';
import 'package:flutter_music/ui/shared/radial_drag.dart';

import '../../locator.dart';

class VinylSeekbarModel extends BaseModel {
  AudioPlaybackService audioPlaybackService =
      locator.get<AudioPlaybackService>();
  double progressPercent = 0.0;
  String maxDuration;
  String currentDuration;
  bool isDragging = false;
  RepeatState repeatState = RepeatState.RepeatNone;

  initModel() {
    audioPlaybackService.currentDurationController.stream.listen((duration) {
      if (currentDuration != duration) currentDuration = duration;
      notifyListeners();
    });

    audioPlaybackService.maxDurationController.stream.listen((duration) {
      if (maxDuration != duration) maxDuration = duration;
      notifyListeners();
    });

    audioPlaybackService.progressPercentController.stream.listen((position) {
      if (position != progressPercent) progressPercent = position;
      notifyListeners();
    });
  }

  handleDrags(PolarCoord polarCoordinates) {
    audioPlaybackService.handleDrags(polarCoordinates);
  }

  void handleDragEnd() {
    audioPlaybackService.handleDragEnd();
  }
}

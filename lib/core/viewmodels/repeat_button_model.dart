import 'package:flutter_music/core/enums/viewstate.dart';
import 'package:flutter_music/core/services/audio_playback_service.dart';

import '../../locator.dart';
import 'base_model.dart';

class RepeatButtonModel extends BaseModel {
  AudioPlaybackService _audioPlaybackService = locator<AudioPlaybackService>();
  void onRepeatPressed() {
    if (state == ViewState.RepeatAll)
      setState(ViewState.RepeatOne);
    else if (state == ViewState.RepeatOne)
      setState(ViewState.RepeatNone);
    else if (state == ViewState.RepeatNone) setState(ViewState.RepeatAll);

    _audioPlaybackService.repeatState = state;
    notifyListeners();
  }
}

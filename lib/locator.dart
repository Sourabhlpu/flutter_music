import 'package:get_it/get_it.dart';

import 'core/services/audio_playback_service.dart';
import 'core/services/fetch_songs.dart';
import 'core/viewmodels/home_model.dart';
import 'core/viewmodels/now_playing_model.dart';
import 'core/viewmodels/repeat_button_model.dart';
import 'core/viewmodels/songs_model.dart';
import 'core/viewmodels/vinyl_seekbar_model.dart';
import 'package:audioplayers/audioplayers.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => SongsModel());
  locator.registerLazySingleton(() => FetchSongsService());
  locator.registerFactory(() => VinylSeekbarModel());
  locator.registerLazySingleton(() => AudioPlayer());
  locator.registerFactory(() => NowPlayingModel());
  locator.registerFactory(() => RepeatButtonModel());
  locator.registerLazySingleton(() => AudioPlaybackService());
}

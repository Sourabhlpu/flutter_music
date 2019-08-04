import 'package:get_it/get_it.dart';

import 'core/services/fetch_songs.dart';
import 'core/viewmodels/home_model.dart';
import 'core/viewmodels/songs_model.dart';
import 'core/viewmodels/vinyl_seekbar_model.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => SongsModel());
  locator.registerLazySingleton(() => FetchSongsService());
  locator.registerFactory(() => VinylSeekbarModel());
}

import 'package:flutter/material.dart';
import 'package:flutter_music/ui/router.dart';
import 'package:provider/provider.dart';
import 'package:songs_meta/song.dart';

import 'core/services/fetch_songs.dart';
import 'core/viewmodels/songs_model.dart';
import 'locator.dart';
import 'ui/shared/app_colors.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Song>>(
      initialData: [],
      builder: (context) => locator<FetchSongsService>().songsController.stream,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            scaffoldBackgroundColor: backgroundColor,
            primaryColor: primaryColor,
            iconTheme: IconThemeData(color: Colors.white),
            accentColor: pink),
        initialRoute: '/',
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_music/ui/views/home_view.dart';
import 'package:flutter_music/ui/views/now_playing_view.dart';
import 'package:songs_meta/song.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'now_playing':
        Song selectedSong = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => NowPlaying(
                song: selectedSong,
              ),
        );
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}

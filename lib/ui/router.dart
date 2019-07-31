import 'package:flutter/material.dart';
import 'package:flutter_music/ui/views/home_view.dart';
import 'package:flutter_music/ui/views/now_playing_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => NowPlaying());
      case 'now_playing':
        return MaterialPageRoute(builder: (_) => NowPlaying());
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

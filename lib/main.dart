import 'package:flutter/material.dart';
import 'package:flutter_music/ui/router.dart';

import 'locator.dart';
import 'ui/shared/app_colors.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          primaryColor: primaryColor,
          iconTheme: IconThemeData(color: Colors.white),
          accentColor: pink),
      initialRoute: '/',
      onGenerateRoute: Router.generateRoute,
    );
  }
}

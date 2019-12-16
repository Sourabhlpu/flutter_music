import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_music/core/enums/viewstate.dart';
import 'package:flutter_music/core/viewmodels/songs_model.dart';
import 'package:flutter_music/ui/shared/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:songs_meta/song.dart';

import 'base_view.dart';

class Songs extends StatelessWidget {
  final ValueNotifier<double> scrollPercent;
  final String name;

  Songs({this.scrollPercent, this.name});

  @override
  Widget build(BuildContext context) {
    return BaseView<SongsModel>(
      onModelReady: (model) {
        model.getSongs();
      },
      builder: (context, model, child) => model.state == ViewState.Busy
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              key: PageStorageKey<String>(name),
              slivers: <Widget>[
                SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context)),
              ]..addAll(_getSlivers(model.songs, context)),
            ),
    );
  }

  buildTopRow(Song song, BuildContext context, String key) {
    return Stack(
      children: <Widget>[
        ValueListenableBuilder(
          valueListenable: scrollPercent,
          builder: (BuildContext context, double value, Widget child) {
            return Container(
              width: double.infinity,
              height: 50 * (1 - value),
              decoration: BoxDecoration(color: pink),
            );
          },
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[_buildIndexRow(key), buildSongRow(song, context)],
        )
      ],
    );
  }

  buildSongRow(Song song, BuildContext context) {
    SongsModel model = Provider.of<SongsModel>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'now_playing', arguments: song);
        },
        child: Container(
          color: primaryColor,
          child: ListTile(
            dense: true,
            leading: Icon(
              Icons.album,
              color: Color(0xffe32a76),
              size: 30,
            ),
            title: Text(
              song.title,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            subtitle: Text(
              '${song.title} . ${model.formatSongDuration(song)}',
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            trailing: IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                onPressed: () {}),
          ),
        ),
      ),
    );
  }

  _buildIndexRow(String index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 8.0, bottom: 8.0),
          child: Text(index.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
              )),
        ),
      ),
    );
  }

  List<Widget> _getSlivers(
      HashMap<String, List<Song>> map, BuildContext context) {
    bool shouldBuildTopRow = true;
    var sortedKeys = map.keys.toList()..sort();
    List slivers = sortedKeys
        .map(
          (key) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (shouldBuildTopRow) {
                      shouldBuildTopRow = false;
                      return buildTopRow(map[key][index], context, key);
                    } else if (index == 0)
                      return _buildIndexRow(key);
                    else
                      return buildSongRow(map[key][index - 1], context);
                  },
                  childCount: map[key].length + 1,
                ),
              ),
        )
        .toList();
    return slivers;
  }
}

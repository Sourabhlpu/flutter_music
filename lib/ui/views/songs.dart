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
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final newIndex = index ~/ 2;
                        if (index == 0)
                          return buildTopRow(model.songs[0], context);
                        if (index.isOdd)
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 36),
                            child: Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                          );
                        else
                          return buildSongRow(model.songs[newIndex], context);
                      },
                      childCount: 2 * model.songs.length - 1,
                    ),
                  )
                ],
              ));
  }

  buildTopRow(Song song, BuildContext context) {
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
        buildSongRow(song, context)
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
}

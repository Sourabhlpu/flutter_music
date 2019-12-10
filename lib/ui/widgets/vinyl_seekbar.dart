import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_music/core/enums/viewstate.dart';
import 'package:flutter_music/core/viewmodels/repeat_button_model.dart';
import 'package:flutter_music/core/viewmodels/vinyl_seekbar_model.dart';
import 'package:flutter_music/ui/shared/app_colors.dart';
import 'package:flutter_music/ui/views/base_view.dart';
import 'package:flutter_music/ui/shared/radial_drag.dart';
import 'package:songs_meta/song.dart';

class VinylSeekbar extends StatelessWidget {
  final Song song;

  VinylSeekbar({this.song});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        BaseView<VinylSeekbarModel>(
          onModelReady: (model) {
            model.initModel();
          },
          builder: (context, model, widget) => Stack(
                children: <Widget>[
                  RadialDragGestureDetector(
                      onRadialDragStart: model.handleDragUpdate,
                      onRadialDragEnd: () {
                        model.handleDragEnd();
                      },
                      onRadialDragUpdate: model.handleDragUpdate,
                      child: vinyl(
                        progressPercent: model.progressPercent,
                      )),
                  buildCurrentTime(model),
                  buildTotalTime(model),
                ],
              ),
        ),
        buildShuffle(),
        buildRepeat(context)
      ],
    );
  }

  Widget buildRepeat(BuildContext context) {
    return BaseView<RepeatButtonModel>(
      onModelReady: (model) {
        model.setState(ViewState.RepeatAll);
      },
      builder: (context, model, widget) => Positioned(
            bottom: 0,
            right: 4,
            child: IconButton(
              icon: _getRepeatIcon(model),
              onPressed: () {
                model.onRepeatPressed();
              },
            ),
          ),
    );
  }

  Positioned buildShuffle() {
    return Positioned(
        bottom: 0,
        left: 4,
        child: IconButton(
            icon: Icon(
              Icons.shuffle,
              color: pink,
            ),
            onPressed: () {}));
  }

  Positioned buildTotalTime(VinylSeekbarModel model) {
    return Positioned(
      top: 148,
      right: 0,
      child: Text(
        '${model.maxDuration}',
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  Positioned buildCurrentTime(VinylSeekbarModel model) {
    return Positioned(
      top: 148,
      child: Text(
        '${model.currentDuration}',
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  Icon _getRepeatIcon(RepeatButtonModel model) {
    if (model.state == ViewState.RepeatNone)
      return Icon(Icons.repeat, color: Colors.grey);
    else if (model.state == ViewState.RepeatAll)
      return Icon(Icons.repeat, color: pink);
    else if (model.state == ViewState.RepeatOne)
      return Icon(Icons.repeat_one, color: pink);
    else
      return Icon(Icons.repeat, color: pink);
  }
}

class vinyl extends StatelessWidget {
  final double progressPercent;
  const vinyl({this.progressPercent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustomPaint(
        foregroundPainter: AlbumArtPainter(progress: progressPercent),
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: CircleAvatar(
            radius: 120,
            backgroundImage: AssetImage('images/album_art.jpg'),
          ),
        ),
      ),
    );
  }
}

class AlbumArtPainter extends CustomPainter {
  final double progress;

  AlbumArtPainter({this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    // just defining a lot of paint objects
    Paint pinkInnerThickPaint = Paint();
    pinkInnerThickPaint.color = pink;
    pinkInnerThickPaint.style = PaintingStyle.stroke;
    pinkInnerThickPaint.strokeWidth = 12;

    Paint blackOuterPaint = Paint();
    blackOuterPaint.color = Colors.black;
    blackOuterPaint.style = PaintingStyle.stroke;
    blackOuterPaint.strokeWidth = 10;

    Paint blackCenterFilledPaint = Paint();
    blackCenterFilledPaint.color = backgroundColor;
    blackCenterFilledPaint.style = PaintingStyle.fill;

    Paint pinkThinPaint = Paint();
    pinkThinPaint.color = pink;
    pinkThinPaint.style = PaintingStyle.stroke;
    pinkThinPaint.strokeWidth = 1;

    Paint progressTrackPaint = Paint();
    progressTrackPaint.color = Colors.grey[600];
    progressTrackPaint.style = PaintingStyle.stroke;
    progressTrackPaint.strokeWidth = 4;
    progressTrackPaint.strokeCap = StrokeCap.round;

    Paint progressPaint = Paint();
    progressPaint.color = pink;
    progressPaint.style = PaintingStyle.stroke;
    progressPaint.strokeWidth = 4;
    progressPaint.strokeCap = StrokeCap.round;

    Paint progressTipPainter = Paint();
    progressTipPainter.color = pink;
    progressTipPainter.style = PaintingStyle.fill;

    //get the center of the canvas
    Offset center = Offset(size.height / 2, size.width / 2);
    canvas.drawCircle(center, 20, pinkInnerThickPaint);
    canvas.drawCircle(center, 120, blackOuterPaint);
    canvas.drawCircle(center, 16, blackCenterFilledPaint);
    canvas.drawCircle(center, 108, pinkThinPaint);

    //draw the progress track
    canvas.drawArc(Rect.fromLTWH(0.0, 0.0, size.width, size.height), 0, pi,
        false, progressTrackPaint);

    //draw the progress
    canvas.drawArc(Rect.fromLTWH(0.0, 0.0, size.width, size.height), pi,
        -pi * progress, false, progressPaint);

    //get the x and y coordinates for the thumb
    var theta = pi - pi * progress;
    double dx = (size.width / 2) * cos(theta);
    double dy = (size.width / 2) * sin(theta);
    Offset offset = Offset(dx, dy);

    //draw the thumb
    canvas.drawCircle(offset + center, 8, progressTipPainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

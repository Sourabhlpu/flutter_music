import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_music/ui/shared/app_colors.dart';

class VinylSeekbar extends StatelessWidget {
  const VinylSeekbar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        vinyl(),
        buildCurrentTime(),
        buildTotalTime(),
        buildShuffle(),
        buildRepeat()
      ],
    );
  }

  Positioned buildRepeat() {
    return Positioned(
      bottom: 8,
      right: 20,
      child: Icon(
        Icons.repeat,
        color: pink,
      ),
    );
  }

  Positioned buildShuffle() {
    return Positioned(
      bottom: 8,
      left: 20,
      child: Icon(
        Icons.shuffle,
        color: pink,
      ),
    );
  }

  Positioned buildTotalTime() {
    return Positioned(
      top: 148,
      right: 0,
      child: Text(
        '05.58',
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  Positioned buildCurrentTime() {
    return Positioned(
      top: 148,
      child: Text(
        '00.54',
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}

class vinyl extends StatelessWidget {
  const vinyl({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustomPaint(
        foregroundPainter: AlbumArtPainter(progress: 0.9),
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

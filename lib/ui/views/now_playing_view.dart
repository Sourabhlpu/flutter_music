import 'package:flutter/material.dart';
import 'package:flutter_music/ui/shared/app_colors.dart';
import 'dart:math';

class NowPlaying extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: Text('Now Playing'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
            ),
            Stack(
              children: <Widget>[
                Padding(
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
                ),
                Positioned(
                  top: 148,
                  child: Text(
                    '00.54',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                Positioned(
                  top: 148,
                  right: 0,
                  child: Text(
                    '05.58',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 20,
                  child: Icon(
                    Icons.shuffle,
                    color: pink,
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 20,
                  child: Icon(
                    Icons.repeat,
                    color: pink,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Column(
              children: <Widget>[
                Text(
                  'Jo Bhi Mai',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  'Rockstar',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.skip_previous,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
                IconButton(
                  iconSize: 50,
                  icon: Icon(
                    Icons.pause,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
                IconButton(
                  icon: Icon(
                    Icons.skip_next,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 40,
                right: 40,
                bottom: 2,
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[600],
                      width: 0.3,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'UP NEXT',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 2.0),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('images/album_art.jpg'),
                ),
                title: Text(
                  'Magic',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.5,
                      fontSize: 14),
                ),
                subtitle: Text(
                  'Ghost Stories',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.5,
                      fontSize: 10),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 40,
                right: 40,
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[600],
                      width: 0.3,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'PREVIOUS',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 2.0),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('images/album_art.jpg'),
                ),
                title: Text(
                  'Magic',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.5,
                      fontSize: 14),
                ),
                subtitle: Text(
                  'Ghost Stories',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.5,
                      fontSize: 10),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
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
    // TODO: implement paint
    Paint paint = Paint();
    paint.color = pink;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 12;

    Paint paintOuter = Paint();
    paintOuter.color = Colors.black;
    paintOuter.style = PaintingStyle.stroke;
    paintOuter.strokeWidth = 10;

    Paint paintInner = Paint();
    paintInner.color = backgroundColor;
    paintInner.style = PaintingStyle.fill;

    Paint paintPinkCircle = Paint();
    paintPinkCircle.color = pink;
    paintPinkCircle.style = PaintingStyle.stroke;
    paintPinkCircle.strokeWidth = 1;

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

    Offset center = Offset(size.height / 2, size.width / 2);
    canvas.drawCircle(center, 20, paint);
    canvas.drawCircle(center, 120, paintOuter);
    canvas.drawCircle(center, 16, paintInner);
    canvas.drawCircle(center, 108, paintPinkCircle);

    canvas.drawArc(Rect.fromLTWH(0.0, 0.0, size.width, size.height), 0, pi,
        false, progressTrackPaint);

    canvas.drawArc(Rect.fromLTWH(0.0, 0.0, size.width, size.height), pi,
        -pi * progress, false, progressPaint);

    var theta = pi - pi * progress;
    double dx = (size.width / 2) * cos(theta);
    double dy = (size.width / 2) * sin(theta);
    Offset offset = Offset(dx, dy);

    canvas.drawCircle(offset + center, 8, progressTipPainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

import 'dart:ui';

import 'package:ed_mahjong/engine/layouts/layout_meta.dart';
import 'package:flutter/material.dart';

class LayoutPreview extends StatefulWidget {
  final LayoutMeta layoutMeta;
  final int? time;

  LayoutPreview({
    Key? key,
    required this.layoutMeta,
    required this.time,
  }) : super(key: key);

  @override
  _LayoutPreviewState createState() => _LayoutPreviewState();
}

class _LayoutPreviewState extends State<LayoutPreview> {
  List<List<List<bool>>>? layout;

  _LayoutPreviewState();

  @override
  initState() {
    super.initState();

    loadInit().catchError((error) {});
  }

  Future<void> loadInit() async {
    final layoutMeta = widget.layoutMeta;
    final layout = await layoutMeta.getLayout(this.context);

    setState(() {
      this.layout = layout.pieces;
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = PlatformDispatcher.instance.locale;
    final label = widget.layoutMeta.name.toLocaleString(locale);
    final text = Center(
        child: Stack(
      children: <Widget>[
        // Stroked text as border.
        Text(
          label,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 20,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 3
              ..color = Colors.white,
          ),
        ),
        // Solid text as fill.
        Text(
          label,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ],
    ));

    final layout = this.layout;
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    final time = widget.time;

    return Stack(
      children: [
        layout != null
            ? CustomPaint(
                painter: LayoutPreviewPainter(layout, brightnessValue),
                child: text,
              )
            : text,
        if (time != null)
          Positioned(
            child: Text(timeToString(time)),
            bottom: 0,
            right: 0,
          )
      ],
    );
  }
}

timeToString(int givenMilliSeconds) {
  final givenSeconds = givenMilliSeconds / 1000;
  final hours = (givenSeconds / 3600).floor();
  final minutes = ((givenSeconds - (hours * 3600)) / 60).floor();
  final seconds = givenSeconds - (hours * 3600) - (minutes * 60);

  return hours.toString().padLeft(2, '0') +
      ':' +
      minutes.toString().padLeft(2, '0') +
      ':' +
      seconds.round().toString().padLeft(2, '0');
}

class LayoutPreviewPainter extends CustomPainter {
  static const lightColor = Color(0x33000000);
  static const darkColor = Color(0x33FFFFFF);

  final Brightness brightnessValue;
  final List<List<List<bool>>> layout;

  LayoutPreviewPainter(this.layout, this.brightnessValue);

  @override
  void paint(Canvas canvas, Size size) {
    final yCount = layout[0].length;
    final xCount = layout[0][0].length;

    final tileWidth = size.width / (xCount / 2 + 2);
    final tileHeight = size.height / (yCount / 2 + 2);

    final tileHWidth = tileWidth / 2;
    final tileHHeight = tileHeight / 2;

    final paint = Paint()
      ..color = (brightnessValue == Brightness.light ? lightColor : darkColor);

    for (var layer in layout) {
      for (var y = 0; y < yCount; ++y) {
        for (var x = 0; x < xCount; ++x) {
          if (!layer[y][x]) continue;
          canvas.drawRect(
              Rect.fromLTWH((x + 2) * tileHWidth, (y + 2) * tileHHeight,
                  tileWidth, tileHeight),
              paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(LayoutPreviewPainter oldDelegate) => false;
}

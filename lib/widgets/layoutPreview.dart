import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/engine/layouts/layout_meta.dart';

class LayoutPreview extends StatefulWidget {
  final LayoutMeta layoutMeta;

  LayoutPreview({
    Key? key,
    required this.layoutMeta,
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
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ],
    ));

    final layout = this.layout;

    return Stack(
      children: [
        layout != null
            ? CustomPaint(
                painter: LayoutPreviewPainter(layout),
                child: text,
              )
            : text,
      ],
    );
  }
}

class LayoutPreviewPainter extends CustomPainter {
  static const color = Color(0xFFAAAAAA);
  final List<List<List<bool>>> layout;

  LayoutPreviewPainter(this.layout);

  @override
  void paint(Canvas canvas, Size size) {
    final yCount = layout[0].length;
    final xCount = layout[0][0].length;

    final tileWidth = size.width / (xCount / 2 + 2);
    final tileHeight = size.height / (yCount / 2 + 2);

    final tileHWidth = tileWidth / 2;
    final tileHHeight = tileHeight / 2;

    final paint = Paint()..color = color;

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

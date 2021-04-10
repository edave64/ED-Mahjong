import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  Tile({key, this.text}) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: 1 / 2, child: Center(child: Text(text!)));
  }
}

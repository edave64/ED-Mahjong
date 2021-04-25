import 'package:flutter_app/engine/layouts/layout_precalc.dart';
import 'package:quiver/core.dart';

class Layout {
  final List<List<List<bool>>> _pieces;
  final int depth;
  final int height;
  final int width;

  Layout(this._pieces)
      : depth = _pieces.length,
        height = _pieces[0].length,
        width = _pieces[0][0].length;

  LayoutPrecalc getPrecalc() {
    return LayoutPrecalc(this, this._pieces);
  }
}

class Coordinate {
  final int x;
  final int y;
  final int z;
  final int hash;

  Coordinate(this.x, this.y, this.z) : hash = hash3(x, y, z);

  bool operator ==(Object other) {
    return other is Coordinate && x == other.x && y == other.y && z == other.z;
  }

  int get hashCode => hash;
}

import 'package:ed_mahjong/engine/layouts/layout_meta.dart';
import 'package:ed_mahjong/engine/pieces/game_board.dart';
import 'package:ed_mahjong/engine/tileset/tileset_meta.dart';
import 'package:ed_mahjong/preferences.dart';
import 'package:ed_mahjong/widgets/tile_animation_layer.dart';
import 'package:ed_mahjong/widgets/tile_layer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef void Selected(int x, int y, int z);

class Board extends StatelessWidget {
  final LayoutMeta meta;
  final GameBoard board;
  final int? selectedX;
  final int? selectedY;
  final int? selectedZ;
  final Selected? onSelected;
  final TileAnimationLayer tileAnimationLayer;

  Board(
      {Key? key,
      required this.board,
      required this.meta,
      required this.tileAnimationLayer,
      this.selectedX,
      this.selectedY,
      this.selectedZ,
      this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<TilesetMetaCollection?, Preferences?>(builder: (context,
        TilesetMetaCollection? tilesetMetas, Preferences? preferences, child) {
      if (tilesetMetas == null || preferences == null)
        return Text("Loading...");
      final highlightMovables = preferences.highlightMovables;
      final tileset = tilesetMetas.get(preferences.tileset);

      final singleLayerSize = tileset.getLayoutSize(board.width, board.height);

      return FittedBox(
          child: SizedBox(
              width: singleLayerSize.x + tileset.levelOffsetX * board.depth,
              height: singleLayerSize.y + tileset.levelOffsetY * board.depth,
              child: Stack(children: [
                ...List.generate(board.depth, (z) {
                  return Positioned(
                      left: tileset.levelOffsetX * z * 1.0,
                      bottom: tileset.levelOffsetY * z * 1.0,
                      child: TileLayer(
                        highlightMovables: highlightMovables,
                        tiles: board.tiles[z],
                        z: z,
                        meta: meta,
                        tileset: tileset,
                        movable: board.movable,
                        selectedX: selectedZ == z ? selectedX : null,
                        selectedY: selectedZ == z ? selectedY : null,
                        onSelected: (x, y, z) {
                          final selected = onSelected;
                          if (selected != null) selected(x, y, z);
                        },
                      ));
                }),
                tileAnimationLayer,
              ])));
    });
  }
}

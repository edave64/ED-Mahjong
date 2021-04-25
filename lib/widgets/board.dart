import 'package:flutter/material.dart';
import 'package:flutter_app/engine/layouts/layout_meta.dart';
import 'package:flutter_app/engine/pieces/game_board.dart';
import 'package:flutter_app/engine/tileset/tileset_meta.dart';
import 'package:flutter_app/widgets/tile_layer.dart';
import 'package:provider/provider.dart';

typedef void Selected(int x, int y, int z);

class Board extends StatelessWidget {
  final LayoutMeta meta;
  final GameBoard board;
  final int? selectedX;
  final int? selectedY;
  final int? selectedZ;
  final Selected? onSelected;

  Board(
      {Key? key,
      required this.board,
      required this.meta,
      this.selectedX,
      this.selectedY,
      this.selectedZ,
      this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TilesetMetaCollection?>(
        builder: (context, TilesetMetaCollection? tilesetMetas, child) {
      if (tilesetMetas == null) return Text("Loading");
      final tileset = tilesetMetas.get("default.desktop");

      final halfTileW = tileset.tileFaceWidth / 2;
      final halfTileH = tileset.tileFaceHeight / 2;

      return FittedBox(
          child: SizedBox(
              width: (halfTileW * (board.width + 1)) +
                  tileset.levelOffsetX * board.depth,
              height: (halfTileH * (board.height + 1)) +
                  tileset.levelOffsetY * board.depth,
              child: Stack(
                  children: List.generate(board.depth, (z) {
                return Positioned(
                    left: tileset.levelOffsetX * z * 1.0,
                    bottom: tileset.levelOffsetY * z * 1.0,
                    child: TileLayer(
                      tiles: board.tiles[z],
                      z: z,
                      meta: meta,
                      tileset: tileset,
                      selectedX: selectedZ == z ? selectedX : null,
                      selectedY: selectedZ == z ? selectedY : null,
                      onSelected: (x, y, z) {
                        final selected = onSelected;
                        if (selected != null) selected(x, y, z);
                      },
                    ));
              }))));
    });
  }
}

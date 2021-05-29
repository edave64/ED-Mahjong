import 'package:ed_mahjong/engine/layouts/layout_meta.dart';
import 'package:ed_mahjong/engine/pieces/game_board.dart';
import 'package:ed_mahjong/engine/tileset/tileset_meta.dart';
import 'package:ed_mahjong/engine/tileset/tileset_renderer.dart';
import 'package:ed_mahjong/preferences.dart';
import 'package:ed_mahjong/widgets/tile_animation_layer.dart';
import 'package:ed_mahjong/widgets/tile_layer_painter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef void Selected(int x, int y, int z);

class Board extends StatelessWidget {
  final LayoutMeta meta;
  final GameBoard board;
  final int? selectedX;
  final int shuffleId;
  final int? selectedY;
  final int? selectedZ;
  final Selected? onSelected;
  final TileAnimationLayer tileAnimationLayer;

  Board({
    Key? key,
    required this.board,
    required this.meta,
    required this.tileAnimationLayer,
    required this.shuffleId,
    this.selectedX,
    this.selectedY,
    this.selectedZ,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<TilesetMetaCollection?, Preferences?>(builder: (context,
        TilesetMetaCollection? tilesetMetas, Preferences? preferences, child) {
      if (tilesetMetas == null || preferences == null)
        return Text("Loading...");
      final highlightMovables = preferences.highlightMovables;
      final tileset = tilesetMetas.get(preferences.tileset);

      final singleLayerSize = tileset.getLayoutSize(board.width, board.height);

      return FutureBuilder(
          future: tileset.getRenderer(context),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              print(snapshot.stackTrace);
              return Text("Error");
            }
            if (!snapshot.hasData) return Text("Loading...");
            return FittedBox(
                child: SizedBox(
                    width:
                        singleLayerSize.x + tileset.levelOffsetX * board.depth,
                    height:
                        singleLayerSize.y + tileset.levelOffsetY * board.depth,
                    child: Stack(children: [
                      RepaintBoundary(
                          child: Stack(
                        children: [
                          ...List.generate(board.depth, (z) {
                            return Positioned(
                                left: tileset.levelOffsetX * z * 1.0,
                                bottom: tileset.levelOffsetY * z * 1.0,
                                child: TileLayerPainter(
                                  shuffleId: shuffleId,
                                  highlightMovables: highlightMovables,
                                  tiles: board.tiles[z],
                                  z: z,
                                  meta: meta,
                                  tileset: tileset,
                                  renderer: snapshot.data as TilesetRenderer,
                                  movable: board.movable,
                                  selectedX: selectedZ == z ? selectedX : null,
                                  selectedY: selectedZ == z ? selectedY : null,
                                  onSelected: (x, y, z) {
                                    final selected = onSelected;
                                    if (selected != null) selected(x, y, z);
                                  },
                                ));
                          }),
                        ],
                      )),
                      tileAnimationLayer,
                    ])));
          });
    });
  }
}

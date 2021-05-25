import 'package:ed_mahjong/engine/layouts/layout.dart';
import 'package:ed_mahjong/engine/pieces/mahjong_tile.dart';
import 'package:ed_mahjong/engine/tileset/tileset_meta.dart';
import 'package:ed_mahjong/widgets/tile.dart';
import 'package:ed_mahjong/widgets/tile_layer.dart';
import 'package:flutter/material.dart';

class TileAnimationLayer extends StatefulWidget {
  final TilesetMeta tilesetMeta;
  final int depth;
  final AnimationPasser _passer = AnimationPasser();

  TileAnimationLayer({Key? key, required this.tilesetMeta, required this.depth})
      : super(key: key);

  void createAnimation(MahjongTile tile, Coordinate coord, FlyDirection dir) {
    _passer.createAnimation(tile, coord, dir);
  }

  @override
  _TileAnimationLayerState createState() => _TileAnimationLayerState(_passer);
}

class _TileAnimationLayerState extends State<TileAnimationLayer>
    with TickerProviderStateMixin {
  final List<TileDismissalAnimation> activeAnimations = [];

  _TileAnimationLayerState(AnimationPasser passer) {
    passer._onCreateAnimation = createAnimation;
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
        child: IgnorePointer(
            child: Stack(
      children: activeAnimations.map((animation) {
        final tilesetMeta = widget.tilesetMeta;
        final pos = tilesetMeta
            .getPixelPos(Coord2D(animation.coord.x, animation.coord.y));

        final yzOffset =
            (widget.depth - animation.coord.z) * tilesetMeta.levelOffsetY;

        final xzOffset = (animation.coord.z) * tilesetMeta.levelOffsetX;

        return Positioned(
          height: tilesetMeta.tileHeight * 1.0,
          width: tilesetMeta.tileWidth * 1.0,
          top: pos.y + yzOffset,
          left: pos.x + xzOffset,
          child: Opacity(
            opacity: 1 - animation.animation.value,
            child: Transform.translate(
                offset: Offset(
                    animation.dir == FlyDirection.Left
                        ? -200 * animation.animation.value
                        : 200 * animation.animation.value,
                    0),
                child: Tile(
                    type: animation.tile,
                    tilesetMeta: tilesetMeta,
                    selected: false)),
          ),
        );
      }).toList(growable: false),
    )));
  }

  createAnimation(MahjongTile type, Coordinate coord, FlyDirection dir) {
    var animation = TileDismissalAnimation(this, type, coord, dir);
    animation.controller.forward();
    animation.animation.addListener(() {
      if (animation.animation.isCompleted) {
        setState(() {
          activeAnimations.remove(animation);
        });
      } else {
        setState(() {});
      }
    });

    setState(() {
      activeAnimations.add(animation);
    });
  }

  @override
  void dispose() {
    for (var animation in activeAnimations) {
      animation.controller.dispose();
    }
    super.dispose();
  }
}

class TileDismissalAnimation {
  final MahjongTile tile;
  final Coordinate coord;
  final AnimationController controller;
  late final Animation<double> animation;
  final dir;

  TileDismissalAnimation(
      _TileAnimationLayerState _state, this.tile, this.coord, this.dir)
      : controller = AnimationController(
            duration: const Duration(milliseconds: 1000), vsync: _state) {
    animation = Tween<double>(begin: 0, end: 1).animate(
        new CurvedAnimation(parent: controller, curve: Curves.easeOutCirc));
  }
}

enum FlyDirection { Left, Right }

class AnimationPasser {
  Function(MahjongTile tile, Coordinate coord, FlyDirection dir)?
      _onCreateAnimation;

  void createAnimation(MahjongTile tile, Coordinate coord, FlyDirection dir) {
    final _onCreateAnimation = this._onCreateAnimation;
    if (_onCreateAnimation != null) _onCreateAnimation(tile, coord, dir);
  }
}

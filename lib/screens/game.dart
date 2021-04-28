import 'dart:ui';

import 'package:ed_mahjong/engine/layouts/layout.dart';
import 'package:ed_mahjong/engine/layouts/layout_meta.dart';
import 'package:ed_mahjong/engine/layouts/top_down_generator.dart';
import 'package:ed_mahjong/engine/pieces/game_board.dart';
import 'package:ed_mahjong/engine/pieces/mahjong_tile.dart';
import 'package:ed_mahjong/engine/tileset/tileset_flutter.dart';
import 'package:ed_mahjong/preferences.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../widgets/board.dart';

class GamePage extends StatefulWidget {
  static const Route = '/game';
  final String layout;

  static PageRoute<dynamic>? generateRoute(
      RouteSettings routeSettings, Uri uri) {
    var id =
        uri.pathSegments.length > 1 ? uri.pathSegments[1] : "default.desktop";
    return MaterialPageRoute(builder: (context) => GamePage(layout: id));
  }

  GamePage({Key? key, required this.layout}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  GameBoard? board;
  LayoutMeta? layoutMeta;
  bool ready = false;
  int? selectedX;
  int? selectedY;
  int? selectedZ;

  _GamePageState();

  @override
  initState() {
    super.initState();
    print(widget.layout);

    loadInit().catchError((error) {});
  }

  @override
  void didUpdateWidget(GamePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("update widget");
    if (widget.layout != oldWidget.layout) {
      setState(() {
        board = null;
        layoutMeta = null;
      });
      loadInit().catchError((error) {});
    }
  }

  Future<void> loadInit() async {
    final layoutMetas = await LayoutMetaCollection.load(this.context);
    final tilesetMetas = await loadTilesets(this.context);
    final layoutMeta = layoutMetas.get(widget.layout);
    final layout = await layoutMeta.getLayout(this.context);
    final preferences = await Preferences.instance;
    final tileset = tilesetMetas.get(preferences.tileset);

    final imgs = [
      "TILE_1",
      "TILE_1_SEL",
      ...MahjongTile.values.map((tile) => tileToString(tile))
    ];

    final base =
        'assets/tilesets/${basenameWithoutExtension(tileset.fileName)}';

    await Future.wait(imgs
        .map((s) => precacheImage(AssetImage('$base/$s.png'), this.context)));

    final precalc = layout.getPrecalc();
    GameBoard? b;
    do {
      try {
        b = makeBoard(layout, precalc);
        if (b.matchable.length == 0) {
          b = null;
          continue;
        }
      } catch (e, stack) {
        print(e);
        print(stack);
        continue;
      }
      break;
    } while (b == null);

    setState(() {
      this.layoutMeta = layoutMeta;
      print("Rebuilding board from ${layoutMeta.name}");
      board = b;
    });
  }

  Future<void> shuffle() async {
    final board = this.board!;
    final layout = board.layout;

    List<MahjongTile> tileSupply = [];
    for (var layer in board.tiles) {
      for (var row in layer) {
        for (var tile in row) {
          if (tile == null) continue;
          tileSupply.add(tile);
        }
      }
    }

    var precalc = layout.getPrecalc();

    GameBoard newBoard;
    try {
      newBoard = makeBoard(layout, precalc, tileSupply);
    } catch (e) {
      showLoosingDialog("The game has become unsolvable");
      return;
    }

    setState(() {
      this.board = newBoard;
    });
  }

  showWinningDialog() {
    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("You won!"),
          actions: <Widget>[
            TextButton(
                child: Text('Yay!'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  showLoosingDialog(String reason) {
    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("You lost! $reason."),
          actions: <Widget>[
            TextButton(
                child: Text('Yay!'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  showShuffleDialog() {
    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("No more available moves"),
          actions: <Widget>[
            TextButton(
                child: Text('Shuffle'),
                onPressed: () {
                  shuffle();
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = PlatformDispatcher.instance.locale;
    return Scaffold(
      appBar: AppBar(
        title: Text(layoutMeta == null
            ? 'Ingame'
            : layoutMeta!.name.toLocaleString(locale)),
      ),
      body: Center(
          child: board == null
              ? Text("Loading...")
              : Board(
                  board: board!,
                  meta: layoutMeta!,
                  selectedX: selectedX,
                  selectedY: selectedY,
                  selectedZ: selectedZ,
                  onSelected: (x, y, z) {
                    final board = this.board!;
                    final oldSelectedX = this.selectedX;
                    final oldSelectedY = this.selectedY;
                    final oldSelectedZ = this.selectedZ;

                    if (x == oldSelectedX &&
                        y == oldSelectedY &&
                        z == oldSelectedZ) return;

                    final coord = Coordinate(x, y, z);
                    if (!board.movable.contains(coord)) return;

                    if (oldSelectedX == null ||
                        oldSelectedY == null ||
                        oldSelectedZ == null) {
                      setState(() {
                        this.selectedX = x;
                        this.selectedY = y;
                        this.selectedZ = z;
                      });
                      return;
                    }

                    final selected =
                        board.tiles[oldSelectedZ][oldSelectedY][oldSelectedX];
                    final newTile = board.tiles[z][y][x];

                    if (selected != null &&
                        newTile != null &&
                        tilesMatch(selected, newTile)) {
                      setState(() {
                        board.update((tiles) {
                          tiles[oldSelectedZ][oldSelectedY][oldSelectedX] =
                              null;
                          tiles[z][y][x] = null;
                        });
                      });

                      final newMovables = board.movable;
                      final Set<MahjongTile> tiles = {};
                      bool movesLeft = false;

                      for (var moveableCoord in newMovables) {
                        final tile = board.tiles[moveableCoord.z]
                            [moveableCoord.y][moveableCoord.x]!;
                        final normalizedTile = isSeason(tile)
                            ? MahjongTile.SEASON_1
                            : isFlower(tile)
                                ? MahjongTile.FLOWER_1
                                : tile;
                        if (tiles.contains(normalizedTile)) {
                          movesLeft = true;
                          print("Pair of ${tileToString(tile)}");
                          break;
                        }
                        tiles.add(normalizedTile);
                      }

                      if (!movesLeft) {
                        final tiles = board.tiles;

                        var empty = true;

                        boardSearch:
                        for (var layer in tiles) {
                          for (var row in layer) {
                            for (var tile in row) {
                              if (tile != null) {
                                empty = false;
                                break boardSearch;
                              }
                            }
                          }
                        }

                        if (empty) {
                          showWinningDialog();
                        } else {
                          showShuffleDialog();
                        }
                      }
                      setState(() {
                        selectedX = null;
                        selectedY = null;
                        selectedZ = null;
                      });
                    } else {
                      setState(() {
                        this.selectedX = x;
                        this.selectedY = y;
                        this.selectedZ = z;
                      });
                    }
                  },
                )),
    );
  }
}

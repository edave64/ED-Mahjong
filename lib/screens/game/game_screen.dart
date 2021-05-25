import 'dart:ui';

import 'package:ed_mahjong/engine/backgrounds/background_meta.dart';
import 'package:ed_mahjong/engine/highscore_storage.dart';
import 'package:ed_mahjong/engine/layouts/layout.dart';
import 'package:ed_mahjong/engine/layouts/layout_meta.dart';
import 'package:ed_mahjong/engine/layouts/top_down_generator.dart';
import 'package:ed_mahjong/engine/pieces/game_board.dart';
import 'package:ed_mahjong/engine/pieces/mahjong_tile.dart';
import 'package:ed_mahjong/engine/tileset/tileset_flutter.dart';
import 'package:ed_mahjong/engine/tileset/tileset_meta.dart';
import 'package:ed_mahjong/preferences.dart';
import 'package:ed_mahjong/screens/game/history_drawer.dart';
import 'package:ed_mahjong/screens/game/menu_drawer.dart';
import 'package:ed_mahjong/widgets/layout_preview.dart';
import 'package:ed_mahjong/widgets/tile_animation_layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../../widgets/board.dart';

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
  TilesetMeta? tilesetMeta;
  List<HistoryState> history = [];
  bool ready = false;
  int? selectedX;
  int? selectedY;
  int? selectedZ;

  int? startAt;
  int shuffles = 0;
  int maxShuffles = -1;

  _GamePageState();

  @override
  initState() {
    super.initState();
    loadInit().catchError((error) {});
  }

  @override
  void didUpdateWidget(GamePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.layout != oldWidget.layout) {
      setState(() {
        board = null;
        layoutMeta = null;
      });
      loadInit().catchError((error) {
        print(error);
      });
    }
  }

  Future<void> loadInit() async {
    final layoutMetas = await LayoutMetaCollection.load(this.context);
    final tilesetMetas = await loadTilesets(this.context);
    final layoutMeta = layoutMetas.get(widget.layout);
    final baseLayout = await layoutMeta.getLayout(this.context);
    final preferences = await Preferences.instance;
    final tileset = tilesetMetas.get(preferences.tileset);

    final layout = baseLayout.compress();

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
    try {
      b = makeBoard(layout, precalc);
    } catch (e) {
      await showLoosingDialog("The layout is impossible to solve");
      return;
    }

    setState(() {
      this.startAt = DateTime.now().millisecondsSinceEpoch;
      this.maxShuffles = preferences.maxShuffles;
      this.layoutMeta = layoutMeta;
      this.tilesetMeta = tileset;
      board = b;
    });
  }

  Future<void> shuffle() async {
    if (!canShuffle) {
      await showLoosingDialog("You don't have any shuffles left");
      return;
    }

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
      await showLoosingDialog("The game has become unsolvable");
      return;
    }

    setState(() {
      this.shuffles++;
      this.board = newBoard;
      this.history = [];
    });
  }

  showWinningDialog() async {
    final finalTime =
        DateTime.now().millisecondsSinceEpoch - (this.startAt ?? 0);
    final times = await highscoreDB.getTimes();
    int? existingTime = times[widget.layout];
    bool highScore = existingTime == null || existingTime > finalTime;

    if (highScore) {
      await highscoreDB.set(widget.layout, finalTime);
    }

    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            highScore
                ? "Congratulations! You set a new best time: ${timeToString(finalTime)}"
                : "You won!",
          ),
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

  showLoosingDialog(String reason) async {
    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("You lost! $reason."),
          actions: <Widget>[
            TextButton(
                child: Text('Dang it!'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  showShuffleDialog() async {
    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("No more available moves"),
          actions: <Widget>[
            TextButton(
                child: Text('Shuffle'),
                onPressed: () {
                  Navigator.of(context).pop();
                  shuffle();
                }),
          ],
        );
      },
    );
  }

  TileAnimationLayer? _tileAnimationLayer;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    final locale = PlatformDispatcher.instance.locale;
    final tilesetMeta = this.tilesetMeta;
    final layoutMeta = this.layoutMeta;

    TileAnimationLayer? tileAnimationLayer = this._tileAnimationLayer;
    if (layoutMeta != null &&
        tilesetMeta != null &&
        tileAnimationLayer == null) {
      this._tileAnimationLayer = tileAnimationLayer = TileAnimationLayer(
        tilesetMeta: tilesetMeta,
        depth: this.board!.depth,
      );
    }

    return Scaffold(
      drawer: MenuDrawer(
          canShuffle: canShuffle,
          layoutName: layoutMeta?.name.toLocaleString(locale),
          shuffle: shuffle),
      endDrawer: tilesetMeta == null
          ? null
          : HistoryDrawer(
              tilesetMeta: tilesetMeta,
              history: history,
              restore: restore,
            ),
      body: renderBackground(
        Center(
            child: board == null
                ? Text("Loading...")
                : Board(
                    board: board!,
                    meta: layoutMeta!,
                    selectedX: selectedX,
                    selectedY: selectedY,
                    selectedZ: selectedZ,
                    tileAnimationLayer: tileAnimationLayer!,
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
                        setSelectedCoord(x, y, z);
                        return;
                      }

                      final selected =
                          board.tiles[oldSelectedZ][oldSelectedY][oldSelectedX];
                      final newTile = board.tiles[z][y][x];

                      if (selected != null &&
                          newTile != null &&
                          tilesMatch(selected, newTile)) {
                        setState(() {
                          final oldCoord = Coordinate(
                              oldSelectedX, oldSelectedY, oldSelectedZ);
                          final newCoord = Coordinate(x, y, z);
                          history.add(HistoryState(
                              selected, oldCoord, newTile, newCoord));

                          board.update((tiles) {
                            tileAnimationLayer!.createAnimation(selected,
                                oldCoord, getTileDirection(board, oldCoord));
                            tileAnimationLayer.createAnimation(newTile,
                                newCoord, getTileDirection(board, newCoord));
                            tiles[oldSelectedZ][oldSelectedY][oldSelectedX] =
                                null;
                            tiles[z][y][x] = null;
                          });
                        });

                        checkIsBoardSolveable();
                        setSelectedCoord(null, null, null);
                      } else {
                        setSelectedCoord(x, y, z);
                      }
                    },
                  )),
      ),
      floatingActionButton: Builder(
          builder: (context) => Row(mainAxisSize: MainAxisSize.min, children: [
                FloatingActionButton(
                  heroTag: "menuBtn",
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip: 'Menu',
                  child: Icon(Icons.menu),
                ),
                Container(
                  width: 20,
                  height: 0,
                ),
                FloatingActionButton(
                  heroTag: "historyBtn",
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  tooltip: 'History',
                  child: Icon(Icons.history),
                )
              ])),
    );
  }

  FlyDirection getTileDirection(GameBoard board, Coordinate coord) {
    if (coord.x < 2) return FlyDirection.Left;
    if (coord.x > board.width - 2) return FlyDirection.Right;
    final layer = board.tiles[coord.z];
    final precalc = board.precalc;
    final idx = precalc.coordToIdx(coord);

    for (var leftIdx in precalc.neighborsLeft[idx]) {
      final nCoord = precalc.idxToCoordinate(leftIdx);
      if (layer[nCoord.y][nCoord.x] != null) return FlyDirection.Right;
    }
    for (var rightIdx in precalc.neighborsRight[idx]) {
      final nCoord = precalc.idxToCoordinate(rightIdx);
      if (layer[nCoord.y][nCoord.x] != null) return FlyDirection.Left;
    }
    if (coord.x < board.width / 2) {
      return FlyDirection.Left;
    }
    return FlyDirection.Right;
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  Widget renderBackground(Widget body) {
    return Consumer2<Preferences?, BackgroundMetaCollection?>(builder: (context,
        Preferences? preferences,
        BackgroundMetaCollection? backgrounds,
        child) {
      if (preferences == null || backgrounds == null) return body;
      final background = preferences.background;
      if (background == null) return body;
      final meta = backgrounds.get(background);
      return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/backgrounds/${meta.fileName}"),
                repeat: ImageRepeat.repeat,
                fit: BoxFit.none),
          ),
          child: body);
    });
  }

  setSelectedCoord(int? x, int? y, int? z) {
    setState(() {
      this.selectedX = x;
      this.selectedY = y;
      this.selectedZ = z;
    });
  }

  checkIsBoardSolveable() async {
    final board = this.board;
    if (board == null) return;

    final newMovables = board.movable;
    final Set<MahjongTile> tiles = {};
    bool movesLeft = false;

    for (var moveableCoord in newMovables) {
      final tile =
          board.tiles[moveableCoord.z][moveableCoord.y][moveableCoord.x]!;
      final normalizedTile = isSeason(tile)
          ? MahjongTile.SEASON_1
          : isFlower(tile)
              ? MahjongTile.FLOWER_1
              : tile;
      if (tiles.contains(normalizedTile)) {
        movesLeft = true;
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
        await showWinningDialog();
      } else {
        await showShuffleDialog();
      }
    }
  }

  bool get canShuffle {
    if (maxShuffles == -1) return true;
    return shuffles < maxShuffles;
  }

  int get shuffleLeft {
    if (maxShuffles == -1) return -1;
    return maxShuffles - shuffles;
  }

  restore(HistoryState state) {
    var idx = history.indexOf(state);
    var historyStates = history.skip(idx).toList().reversed;

    if (idx == -1) return;

    setState(() {
      board!.update((tiles) {
        for (var state in historyStates) {
          tiles[state.tile1Coord.z][state.tile1Coord.y][state.tile1Coord.x] =
              state.tile1;
          tiles[state.tile2Coord.z][state.tile2Coord.y][state.tile2Coord.x] =
              state.tile2;
        }
      });
      this.history = this.history.take(idx).toList();
    });
  }
}

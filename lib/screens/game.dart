import 'package:flutter/material.dart';
import 'package:flutter_app/engine/layouts/layout_meta.dart';
import 'package:flutter_app/engine/pieces/game_board.dart';

import '../widgets/board.dart';

class GamePage extends StatefulWidget {
  static const Route = '/game';
  final String layout;

  static PageRoute<dynamic>? generateRoute(RouteSettings routeSettings) {
    final name = routeSettings.name;
    if (name == null || !name.startsWith(Route)) return null;
    final segments = name.split('/');
    if (segments.length == 0)
      return MaterialPageRoute(
          builder: (context) => GamePage(layout: "default.desktop"));
    return MaterialPageRoute(
        builder: (context) => GamePage(layout: segments[2]));
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
    final layoutMetas = await LayoutMetaCollection.load(context);
    final layoutMeta = layoutMetas.get(widget.layout);
    final layout = await layoutMeta.getLayout(context);
    setState(() {
      this.layoutMeta = layoutMeta;
      print("Rebuilding board from ${layoutMeta.name}");
      board = layout.makeBoard();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("building widget");
    return Scaffold(
      appBar: AppBar(
        title:
            Text(layoutMeta == null ? 'Ingame' : layoutMeta!.name.toString()),
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
                    setState(() {
                      final oldSelectedX = this.selectedX;
                      final oldSelectedY = this.selectedY;
                      final oldSelectedZ = this.selectedZ;

                      if (x == oldSelectedX && y == oldSelectedY && z == oldSelectedZ) return;

                      if (oldSelectedX != null &&
                          oldSelectedY != null &&
                          oldSelectedZ != null) {
                        final selected = board!.tiles[oldSelectedZ]
                            [oldSelectedY][oldSelectedX];
                        final newTile = board!.tiles[z][y][x];
                        if (selected != null && selected == newTile) {
                          setState(() {
                            board!.tiles[oldSelectedZ][oldSelectedY]
                                [oldSelectedX] = null;
                            board!.tiles[z][y][x] = null;
                            selectedX = null;
                            selectedY = null;
                            selectedZ = null;
                          });
                          return;
                        }
                      }
                      this.selectedX = x;
                      this.selectedY = y;
                      this.selectedZ = z;
                    });
                  },
                )),
    );
  }
}

import 'package:ed_mahjong/engine/layouts/layout.dart';
import 'package:ed_mahjong/engine/pieces/mahjong_tile.dart';
import 'package:ed_mahjong/engine/tileset/tileset_meta.dart';
import 'package:ed_mahjong/widgets/tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryDrawer extends StatelessWidget {
  final TilesetMeta tilesetMeta;
  final List<HistoryState> history;
  final Function(HistoryState) restore;

  HistoryDrawer(
      {Key? key,
      required this.history,
      required this.tilesetMeta,
      required this.restore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          header(),
          ...history.reversed.map(tilePair),
        ],
      ),
    );
  }

  Widget header() {
    return Container(
        height: 50.0,
        child: DrawerHeader(
          child: Text('History'),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ));
  }

  Widget tilePair(HistoryState state) {
    return Container(
        height: 100.0,
        child: Center(
            child: InkWell(
                onTap: () {
                  restore(state);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                        child: Tile(
                            selected: false,
                            tilesetMeta: tilesetMeta,
                            type: state.tile1)),
                    FittedBox(
                        child: Tile(
                            selected: false,
                            tilesetMeta: tilesetMeta,
                            type: state.tile2)),
                  ],
                ))));
  }
}

class HistoryState {
  final MahjongTile tile1;
  final Coordinate tile1Coord;
  final MahjongTile tile2;
  final Coordinate tile2Coord;

  HistoryState(this.tile1, this.tile1Coord, this.tile2, this.tile2Coord);
}

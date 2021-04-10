import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/tile.dart';

class TileLayer extends StatelessWidget {
  const TileLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
      },
      //defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            Tile(
              text: 'A',
            ),
            Tile(
              text: 'B',
            ),
            Tile(
              text: 'C',
            ),
            Tile(
              text: 'D',
            ),
            Tile(
              text: 'E',
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            Tile(
              text: 'A',
            ),
            Tile(
              text: 'B',
            ),
            Tile(
              text: 'C',
            ),
            Tile(
              text: 'D',
            ),
            Tile(
              text: 'E',
            ),
          ],
        ),
      ],
    );
  }
}

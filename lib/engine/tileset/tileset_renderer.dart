import 'package:flutter_svg/svg.dart';

class TilesetRenderer {
  static const a = [
    "TILE_1",
    "TILE_1_SEL",
    "CHARACTER_1",
    "CHARACTER_2",
    "CHARACTER_3",
    "CHARACTER_4",
    "CHARACTER_5",
    "CHARACTER_6",
    "CHARACTER_7",
    "CHARACTER_8",
    "CHARACTER_9",
    "BAMBOO_1",
    "BAMBOO_2",
    "BAMBOO_3",
    "BAMBOO_4",
    "BAMBOO_5",
    "BAMBOO_6",
    "BAMBOO_7",
    "BAMBOO_8",
    "BAMBOO_9",
    "ROD_1",
    "ROD_2",
    "ROD_3",
    "ROD_4",
    "ROD_5",
    "ROD_6",
    "ROD_7",
    "ROD_8",
    "ROD_9",
    "SEASON_1",
    "SEASON_2",
    "SEASON_3",
    "SEASON_4",
    "FLOWER_1",
    "FLOWER_2",
    "FLOWER_3",
    "FLOWER_4",
    "WIND_1",
    "WIND_2",
    "WIND_3",
    "WIND_4",
    "DRAGON_1",
    "DRAGON_2",
    "DRAGON_3"
  ];

  void toast() async {
    final root = await svg.fromSvgString("", "");
    final b = root.children[0];
  }
}

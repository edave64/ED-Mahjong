enum MahjongTile {
  CHARACTER_1,
  CHARACTER_2,
  CHARACTER_3,
  CHARACTER_4,
  CHARACTER_5,
  CHARACTER_6,
  CHARACTER_7,
  CHARACTER_8,
  CHARACTER_9,
  BAMBOO_1,
  BAMBOO_2,
  BAMBOO_3,
  BAMBOO_4,
  BAMBOO_5,
  BAMBOO_6,
  BAMBOO_7,
  BAMBOO_8,
  BAMBOO_9,
  ROD_1,
  ROD_2,
  ROD_3,
  ROD_4,
  ROD_5,
  ROD_6,
  ROD_7,
  ROD_8,
  ROD_9,
  SEASON_1,
  SEASON_2,
  SEASON_3,
  SEASON_4,
  FLOWER_1,
  FLOWER_2,
  FLOWER_3,
  FLOWER_4,
  WIND_1,
  WIND_2,
  WIND_3,
  WIND_4,
  DRAGON_1,
  DRAGON_2,
  DRAGON_3
}

const _EnumName = "MahjongTile";
const _EnumNameLength = _EnumName.length;

final _tileToString = Map.fromEntries(MahjongTile.values.map((tile) => MapEntry(
    tile, tile.toString().substring(_EnumNameLength + 1).toUpperCase())));

final _stringToTile = Map.fromEntries(
    _tileToString.entries.map((pair) => MapEntry(pair.value, pair.key)));

String tileToString(MahjongTile tile) {
  return _tileToString[tile]!;
}

MahjongTile stringToTile(String str) {
  return _stringToTile[str]!;
}

Set<MahjongTile> _flowers = {
  MahjongTile.FLOWER_1,
  MahjongTile.FLOWER_2,
  MahjongTile.FLOWER_3,
  MahjongTile.FLOWER_4,
};

Set<MahjongTile> _season = {
  MahjongTile.SEASON_1,
  MahjongTile.SEASON_2,
  MahjongTile.SEASON_3,
  MahjongTile.SEASON_4,
};

bool tilesMatch(MahjongTile a, MahjongTile b) {
  if (a == b) return true;
  if (_season.contains(a) && _season.contains(b)) return true;
  if (_flowers.contains(a) && _flowers.contains(b)) return true;
  return false;
}

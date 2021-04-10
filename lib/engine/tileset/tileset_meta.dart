import 'package:flutter_app/engine/desktopFileReader/localizable_string.dart';
import 'package:flutter_app/engine/desktopFileReader/parse_spec.dart';
import 'package:flutter_app/engine/desktopFileReader/parser.dart';
import 'package:flutter_app/engine/tileset/tileset_renderer.dart';

final parser = buildTilesetParser();

class TilesetMetaCollection {
  final Map<String, TilesetMeta> _tilesets;

  TilesetMetaCollection(this._tilesets);

  List<TilesetMeta> list() {
    return List.unmodifiable(_tilesets.values);
  }

  TilesetMeta get(String name) {
    if (_tilesets.containsKey(name)) {
      return _tilesets[name]!;
    }
    throw new TilesetNotFound(name);
  }
}

class TilesetMeta {
  final String basename;
  final LocalizableString name;
  final LocalizableString description;
  final String author;
  final String authorEmail;
  final String fileName;
  final int levelOffsetX;
  final int levelOffsetY;
  final int tileFaceWidth;
  final int tileFaceHeight;
  final int tileWidth;
  final int tileHeight;

  TilesetMeta._(this.basename, Map<String, dynamic> desktopData)
      : name = desktopData[KName],
        description = desktopData[KDescription],
        author = desktopData[KAuthor],
        authorEmail = desktopData[KAuthorEmail],
        fileName = desktopData[KFileName],
        levelOffsetX = desktopData[KLevelOffsetX],
        levelOffsetY = desktopData[KLevelOffsetY],
        tileFaceWidth = desktopData[KTileFaceWidth],
        tileFaceHeight = desktopData[KTileFaceHeight],
        tileWidth = desktopData[KTileWidth],
        tileHeight = desktopData[KTileHeight];

  static TilesetMeta LoadString(String basename, String contents) {
    final section = parser.parse_section(contents, KSectionName);
    return TilesetMeta.Deserialize(basename, section);
  }

  static TilesetMeta Deserialize(
      String basename, Map<String, dynamic> desktopData) {
    if (desktopData[KVersionFormat] != 1)
      throw TilesetVersionError(
          desktopData[KName], desktopData[KVersionFormat]);
    if (desktopData.containsKey(KLevelOffset)) {
      final int? offset = desktopData[KLevelOffset];
      desktopData.putIfAbsent(KLevelOffsetX, () => offset);
      desktopData.putIfAbsent(KLevelOffsetY, () => offset);
      desktopData.remove(KLevelOffset);
    }
    return TilesetMeta._(basename, desktopData);
  }

  Future<TilesetRenderer> getRenderer() async {
    return TilesetRenderer();
  }
}

Parser buildTilesetParser() {
  final spec = ParseSpecBuilder();
  final section = spec.section(KSectionName);
  section[KName] = ItemType.LocalizableString;
  section[KDescription] = ItemType.LocalizableString;
  section[KVersionFormat] = ItemType.Int;
  section[KAuthor] = ItemType.String;
  section[KAuthorEmail] = ItemType.String;
  section[KFileName] = ItemType.String;
  section[KLevelOffsetX] = ItemType.Int;
  section[KLevelOffsetY] = ItemType.Int;
  section[KLevelOffset] = ItemType.Int;
  section[KTileFaceWidth] = ItemType.Int;
  section[KTileFaceHeight] = ItemType.Int;
  section[KTileWidth] = ItemType.Int;
  section[KTileHeight] = ItemType.Int;
  return Parser(spec.finish());
}

class TilesetVersionError implements Exception {
  TilesetVersionError(this.name, this.version);
  final String name;
  final int version;
  String toString() => "Tileset '$name' has the unsupported version ''$version";
}

class TilesetNotFound implements Exception {
  TilesetNotFound(this.name);
  final String name;
  String toString() => "Unknown Tileset '$name'";
}

const KSectionName = "KMahjonggTileset";
const KName = "Name";
const KDescription = "Description";
const KVersionFormat = "VersionFormat";
const KAuthor = "Author";
const KAuthorEmail = "AuthorEmail";
const KFileName = "FileName";
const KLevelOffset = "LevelOffset";
const KLevelOffsetX = "LevelOffsetX";
const KLevelOffsetY = "LevelOffsetY";
const KTileFaceWidth = "TileFaceWidth";
const KTileFaceHeight = "TileFaceHeight";
const KTileWidth = "TileWidth";
const KTileHeight = "TileHeight";

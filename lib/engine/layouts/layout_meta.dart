import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_app/engine/desktopFileReader/localizable_string.dart';
import 'package:flutter_app/engine/desktopFileReader/parse_spec.dart';
import 'package:flutter_app/engine/desktopFileReader/parser.dart';
import 'package:flutter_app/engine/layouts/layout.dart';
import 'package:path/path.dart';

final parser = buildTilesetParser();

class LayoutMetaCollection {
  final Map<String, LayoutMeta> _layouts;

  LayoutMetaCollection._(this._layouts);

  List<LayoutMeta> list() {
    return List.unmodifiable(_layouts.values);
  }

  LayoutMeta get(String name) {
    if (!_layouts.containsKey(name)) throw new LayoutNotFound(name);
    return _layouts[name]!;
  }

  static Future<LayoutMetaCollection>? loaded;
  static Future<LayoutMetaCollection> load(BuildContext context) {
    if (loaded == null) loaded = _load(context);
    return loaded!;
  }

  static Future<LayoutMetaCollection> _load(BuildContext context) async {
    if (loaded != null) return await loaded!;
    final assetBundle = DefaultAssetBundle.of(context);
    final manifestContent = await assetBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final allFiles = manifestMap.keys;

    final layoutPaths = allFiles
        .where((String key) => key.startsWith('assets/layouts/'))
        .where((String key) => key.endsWith('.desktop'))
        .toList();

    final Map<String, LayoutMeta> layoutMetas = {};

    await Future.wait(layoutPaths.map((layoutPath) async {
      final layoutFileContent = await assetBundle.loadString(layoutPath);
      final section = parser.parseSection(layoutFileContent, KSectionName);
      final layoutMeta = LayoutMeta.deserialize(basename(layoutPath), section);
      layoutMetas[layoutMeta.basename] = layoutMeta;
    }));

    return LayoutMetaCollection._(Map.unmodifiable(layoutMetas));
  }
}

class LayoutMeta {
  final String basename;
  final LocalizableString name;
  final LocalizableString description;
  final String author;
  final String authorEmail;
  final String fileName;

  LayoutMeta._(this.basename, Map<String, dynamic> desktopData)
      : name = desktopData[KName],
        description = desktopData[KDescription],
        author = desktopData[KAuthor],
        authorEmail = desktopData[KAuthorEmail],
        fileName = desktopData[KFileName];

  static LayoutMeta deserialize(
      String basename, Map<String, dynamic> desktopData) {
    if (desktopData[KVersionFormat] != 1)
      throw LayoutVersionError(desktopData[KName], desktopData[KVersionFormat]);
    return LayoutMeta._(basename, desktopData);
  }

  Future<Layout>? loaded;
  Future<Layout> getLayout(BuildContext context) async {
    if (loaded != null) return await loaded!;
    return await (loaded = _loadLayout(context));
  }

  static const layout10magic = "kmahjongg-layout-v1.0";
  static const layout11magic = "kmahjongg-layout-v1.1";
  final linebreak = RegExp(r"[\n\r]+");
  Future<Layout> _loadLayout(BuildContext context) async {
    if (loaded != null) return await loaded!;

    final assetBundle = DefaultAssetBundle.of(context);
    final layoutFileContent =
        await assetBundle.loadString('assets/layouts/$fileName');

    final lines = layoutFileContent.split(linebreak);
    if (lines.length == 0) throw Exception("Empty layout file");
    switch (lines[0]) {
      case layout10magic:
        return _loadLayout_1_0(lines.skip(1));
      case layout11magic:
        return _loadLayout_1_1(lines.skip(1));
      default:
        throw Exception("Unknown layout type ${lines[0]}");
    }
  }

  Layout _loadLayout_1_0(Iterable<String> lines) {
    final List<String> tiles = [];
    lines:
    for (var line in lines) {
      if (line.length == 0) continue;
      switch (line[0]) {
        case "#":
          continue lines;
        default:
          tiles.addAll(line.split(''));
      }
    }
    return _loadLayoutKde(5, 16, 32, tiles);
  }

  Layout _loadLayout_1_1(Iterable<String> lines) {
    final List<String> tiles = [];
    var width = 0;
    var height = 0;
    var depth = 0;

    for (var line in lines) {
      if (line.length == 0) continue;
      switch (line[0]) {
        case "#":
          break;
        case 'w':
          width = int.parse(line.substring(1));
          break;
        case 'h':
          height = int.parse(line.substring(1));
          break;
        case 'd':
          depth = int.parse(line.substring(1));
          break;
        default:
          tiles.addAll(line.split(''));
      }
    }
    return _loadLayoutKde(depth, height, width, tiles);
  }

  Layout _loadLayoutKde(int depth, int height, int width, List<String> chars) {
    if (depth <= 0 || height <= 0 || width <= 0) {
      throw Exception("Height, width or depth of a layout cannot be zero");
    }
    final List<List<List<bool>>> board = List.generate(
        depth, (_) => List.generate(height, (_) => List.filled(width, false)));
    var tileCount = 0;
    for (var z = 0; z < depth; ++z) {
      for (var y = 0; y < height; ++y) {
        for (var x = 0; x < width; ++x) {
          var cellIdx = x + (y * width) + (z * width * height);
          if (cellIdx >= chars.length) break;
          if (chars[cellIdx] != '1') continue;
          board[z][y][x] = true;
          if (x > 0 && board[z][y][x - 1]) throw Exception("Overlapping tiles");
          if (x > 0 && y > 0 && board[z][y - 1][x - 1])
            throw Exception("Overlapping tiles");
          if (y > 0 && board[z][y - 1][x]) throw Exception("Overlapping tiles");
          ++tileCount;
        }
      }
    }
    if (tileCount % 2 == 1) {
      throw Exception("Number of tiles in a layout needs to be even.");
    }
    return Layout(board);
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
  return Parser(spec.finish());
}

class LayoutVersionError implements Exception {
  LayoutVersionError(this.name, this.version);
  final String name;
  final int version;
  String toString() => "Layout '$name' has the unsupported version ''$version";
}

class LayoutNotFound implements Exception {
  LayoutNotFound(this.name);
  final String name;
  String toString() => "Unknown Layout '$name'";
}

const KSectionName = "KMahjonggLayout";
const KName = "Name";
const KDescription = "Description";
const KVersionFormat = "VersionFormat";
const KAuthor = "Author";
const KAuthorEmail = "AuthorEmail";
const KFileName = "FileName";

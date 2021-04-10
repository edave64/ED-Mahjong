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
  static Future<LayoutMetaCollection> Load(BuildContext context) {
    if (loaded == null) loaded = _Load(context);
    return loaded!;
  }

  static Future<LayoutMetaCollection> _Load(BuildContext context) async {
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
      final section = parser.parse_section(layoutFileContent, KSectionName);
      final layoutMeta = LayoutMeta.Deserialize(basename(layoutPath), section);
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

  static LayoutMeta Deserialize(
      String basename, Map<String, dynamic> desktopData) {
    if (desktopData[KVersionFormat] != 1)
      throw LayoutVersionError(desktopData[KName], desktopData[KVersionFormat]);
    return LayoutMeta._(basename, desktopData);
  }

  Future<Layout> getLayout() async {
    return Layout();
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

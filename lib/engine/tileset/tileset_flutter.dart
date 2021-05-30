import 'dart:convert';

import 'package:ed_mahjong/engine/tileset/tileset_meta.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

const tilesetAssetFolder = 'assets/tilesets/';

Future<TilesetMetaCollection> loadTilesets(BuildContext context) async {
  final assetBundle = DefaultAssetBundle.of(context);
  final manifestContent = await assetBundle.loadString('AssetManifest.json');
  final Map<String, dynamic> manifestMap = json.decode(manifestContent);

  final allFiles = manifestMap.keys;

  final tilesetPaths = allFiles
      .where((String key) => key.startsWith(tilesetAssetFolder))
      .where((String key) => key.endsWith('.desktop'))
      .toList();

  final Map<String, TilesetMeta> tilesetMetas = {};

  await Future.wait(tilesetPaths.map((tilesetPath) async {
    final tilesetFileContent = await assetBundle.loadString(tilesetPath);
    final tilesetMeta =
        TilesetMeta.loadString(basename(tilesetPath), tilesetFileContent);
    tilesetMetas[tilesetMeta.basename] = tilesetMeta;
  }));

  return TilesetMetaCollection(Map.unmodifiable(tilesetMetas));
}

Map<String, Future<String>> licenceLoaders = {};
Future<String> loadLicence(BuildContext context, TilesetMeta tileset) {
  final key = tileset.basename;

  if (licenceLoaders.containsKey(key)) return licenceLoaders[key]!;

  final assetBundle = DefaultAssetBundle.of(context);
  final loader = assetBundle.loadString(tilesetAssetFolder +
      basenameWithoutExtension(tileset.fileName) +
      '.copyright');

  licenceLoaders[key] = loader;
  return loader;
}

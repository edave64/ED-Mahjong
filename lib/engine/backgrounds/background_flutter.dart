import 'dart:convert';

import 'package:ed_mahjong/engine/backgrounds/background_meta.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

Future<BackgroundMetaCollection> loadBackgrounds(BuildContext context) async {
  final assetBundle = DefaultAssetBundle.of(context);
  final manifestContent = await assetBundle.loadString('AssetManifest.json');
  final Map<String, dynamic> manifestMap = json.decode(manifestContent);

  final allFiles = manifestMap.keys;

  final tilesetPaths = allFiles
      .where((String key) => key.startsWith('assets/backgrounds/'))
      .where((String key) => key.endsWith('.desktop'))
      .toList();

  final Map<String, BackgroundMeta> tilesetMetas = {};

  await Future.wait(tilesetPaths.map((tilesetPath) async {
    final backgroundFileContent = await assetBundle.loadString(tilesetPath);
    final backgroundMeta =
        BackgroundMeta.loadString(basename(tilesetPath), backgroundFileContent);
    tilesetMetas[backgroundMeta.basename] = backgroundMeta;
  }));

  return BackgroundMetaCollection(Map.unmodifiable(tilesetMetas));
}

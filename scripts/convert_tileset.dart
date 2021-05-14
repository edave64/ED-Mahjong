import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart';

const tiles = [
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

void main3(List<String> arguments) async {
  final result = await Process.run("inkscape", [
    "--export-type=png",
    "--export-id=DRAGON_1;DRAGON_2;DRAGON_3",
    "c:\\users\\nordern\\androidstudioprojects\\flutter_app\\assets\\tilesets\\jade.svgz"
  ]);
  print(result.stdout);
  print(result.stderr);
}

const tilesetPath = "./assets/tilesets/";

void main(List<String> arguments) async {
  if (arguments.length == 0) {
    arguments = [];
    final listing =
        Directory.fromRawPath(Uint8List.fromList(tilesetPath.codeUnits)).list();
    await for (var file in listing) {
      final base = basename(file.path);
      if (!base.endsWith(".desktop")) continue;
      arguments.add(basenameWithoutExtension(file.path));
    }
  }
  Future.wait(arguments.map((tileset) => pngfyTileset(tileset)));
}

Future<void> pngfyTileset(String tileset) async {
  final desktopFile = '$tileset.desktop';
  File file = new File(tilesetPath + desktopFile);
  String futureContent = await file.readAsString();
  final lines = futureContent.split(RegExp(r"[\n\r]+"));
  // final tilesetMeta = TilesetMeta.LoadString(desktopFile, futureContent);
  for (var line in lines) {
    if (!line.startsWith("FileName=")) continue;
    final file = line.substring(9);
    final target = "$tilesetPath$tileset/";
    await Directory.fromRawPath(Uint8List.fromList(target.codeUnits))
        .create(recursive: true);
    final result = await Process.run("inkscape", [
      "--export-type=png",
      "--export-id=${tiles.join(";")}",
      absolute(canonicalize("$tilesetPath$file"))
    ]);
    print(result.stdout);
    print(result.stderr);
    final listing =
        Directory.fromRawPath(Uint8List.fromList(tilesetPath.codeUnits)).list();
    final tilesetPrefix = basenameWithoutExtension(file) + '_';
    await for (var file in listing) {
      final filename = basename(file.path);
      if (!filename.startsWith(tilesetPrefix) || !filename.endsWith(".png"))
        continue;
      await file.rename(target + filename.substring(tilesetPrefix.length));
    }
  }
}

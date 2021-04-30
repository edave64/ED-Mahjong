import 'package:ed_mahjong/engine/desktopFileReader/localizable_string.dart';
import 'package:ed_mahjong/engine/desktopFileReader/parse_spec.dart';
import 'package:ed_mahjong/engine/desktopFileReader/parser.dart';

final parser = buildTilesetParser();

class BackgroundMetaCollection {
  final Map<String, BackgroundMeta> _backgrounds;

  BackgroundMetaCollection(this._backgrounds);

  List<BackgroundMeta> list() {
    return List.unmodifiable(_backgrounds.values);
  }

  BackgroundMeta get(String name) {
    if (_backgrounds.containsKey(name)) {
      return _backgrounds[name]!;
    }
    throw new BackgroundNotFound(name);
  }
}

class BackgroundMeta {
  final String basename;
  final LocalizableString name;
  final LocalizableString description;
  final String author;
  final String? authorEmail;
  final String fileName;

  BackgroundMeta._(this.basename, Map<String, dynamic> desktopData)
      : name = desktopData[KName],
        description = desktopData[KDescription] ?? LocalizableString.empty,
        author = desktopData[KAuthor],
        authorEmail = desktopData[KAuthorEmail],
        fileName = desktopData[KFileName];

  static BackgroundMeta loadString(String basename, String contents) {
    final section = parser.parseSection(contents, KSectionName);
    return BackgroundMeta.deserialize(basename, section);
  }

  static BackgroundMeta deserialize(
      String basename, Map<String, dynamic> desktopData) {
    if (desktopData[KVersionFormat] != 1)
      throw BackgroundVersionError(
          desktopData[KName], desktopData[KVersionFormat]);
    return BackgroundMeta._(basename, desktopData);
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

class BackgroundVersionError implements Exception {
  BackgroundVersionError(this.name, this.version);
  final String name;
  final int version;
  String toString() =>
      "Background '$name' has the unsupported version ''$version";
}

class BackgroundNotFound implements Exception {
  BackgroundNotFound(this.name);
  final String name;
  String toString() => "Unknown Background '$name'";
}

const KSectionName = "EDMahjongBackground";
const KName = "Name";
const KDescription = "Description";
const KVersionFormat = "VersionFormat";
const KAuthor = "Author";
const KAuthorEmail = "AuthorEmail";
const KFileName = "FileName";

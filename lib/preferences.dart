import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Future<Preferences>? _instanceFuture;

  static Future<Preferences> get instance {
    if (_instanceFuture == null) {
      final completer = Completer<Preferences>();
      _instanceFuture = completer.future;
      SharedPreferences.getInstance()
          .then((sharedPrefs) => completer.complete(Preferences._(sharedPrefs)))
          .onError((error, stackTrace) =>
              completer.completeError(error!, stackTrace));
    }
    return _instanceFuture!;
  }

  Preferences._(this.sharedPrefs);
  final SharedPreferences sharedPrefs;

  static const TilesetProp = "ed:mahjong:tileset";
  static const TilesetDefault = "default.desktop";
  static const BackgroundProp = "ed:mahjong:background";
  static const ShufflesProp = "ed:mahjong:shuffles";
  static const HighlightMovablesProp = "ed:mahjong:highlight_movables";
  static const ShufflesDefault = 1;
  static const HighlightMovablesPropDefault = true;
  static const String? BackgroundDefault = null;

  String get tileset {
    return sharedPrefs.getString(TilesetProp) ?? TilesetDefault;
  }

  set tileset(String tileset) {
    sharedPrefs.setString(TilesetProp, tileset);
  }

  String? get background {
    return sharedPrefs.getString(BackgroundProp) ?? BackgroundDefault;
  }

  set background(String? background) {
    if (background == null) {
      sharedPrefs.remove(BackgroundProp);
      return;
    }
    sharedPrefs.setString(BackgroundProp, background);
  }

  int get maxShuffles {
    return sharedPrefs.getInt(ShufflesProp) ?? ShufflesDefault;
  }

  set maxShuffles(int maxShuffles) {
    sharedPrefs.setInt(ShufflesProp, maxShuffles);
  }

  bool get highlightMovables {
    return sharedPrefs.getBool(HighlightMovablesProp) ??
        HighlightMovablesPropDefault;
  }

  set highlightMovables(bool highlightMovables) {
    sharedPrefs.setBool(HighlightMovablesProp, highlightMovables);
  }
}

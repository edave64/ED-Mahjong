import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Future<Preferences>? _instanceFuture;

  static Future<Preferences> get Instance {
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

  String get tileset {
    return sharedPrefs.getString(TilesetProp) ?? TilesetDefault;
  }

  set tileset(String tileset) {
    sharedPrefs.setString(TilesetProp, tileset);
  }
}

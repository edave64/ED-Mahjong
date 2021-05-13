import 'dart:async';

import 'package:ed_mahjong/engine/db_implementations/sembast.dart';
import 'package:ed_mahjong/engine/db_implementations/sqflite.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

abstract class IHighscoreDB {
  Future<Map<String, int>> getTimes();
  Future<void> set(String layout, int time);
}

class HighscoreDB extends IHighscoreDB {
  HighscoreDB._();
  static final HighscoreDB instance = HighscoreDB._();

  IHighscoreDB get database {
    if (kIsWeb) {
      return HighscoreSembast.instance;
    } else {
      return HighscoreDBSql.instance;
    }
  }

  Map<String, int>? _times;
  Future<void>? _alreadyLoading;
  List<Function()> callbacks = [];

  Future<Map<String, int>> getTimes() async {
    Map<String, int>? _times = this._times;
    if (_times == null) {
      final futureBuilder = Completer<void>();
      this._alreadyLoading = futureBuilder.future;
      this._times = _times = await database.getTimes();
      this._alreadyLoading = null;
      futureBuilder.complete();
    }
    return _times;
  }

  Future<void> set(String layout, int time) async {
    if (_alreadyLoading != null) await _alreadyLoading;
    final _times = this._times;
    if (_times != null) {
      _times[layout] = time;
    } else {
      this._times = {layout: time};
    }
    await database.set(layout, time);

    for (var callback in callbacks) {
      callback();
    }
  }

  onChange(Function() change) {
    callbacks.add(change);
  }
}

final highscoreDB = HighscoreDB.instance;

import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const _tableHighscore = 'highscores';
const _columnLayout = 'layout';
const _columnTime = 'time';

class HighscoreDB {
  static final _databaseName = "Highscores.db";
  static final _databaseVersion = 1;

  HighscoreDB._();
  static final HighscoreDB instance = HighscoreDB._();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    if (version == 1) {
      await db.execute('''
              CREATE TABLE IF NOT EXISTS $_tableHighscore (
                $_columnLayout TEXT NOT NULL PRIMARY KEY,
                $_columnTime INTEGER NOT NULL
              )
              ''');
    }
  }

  Map<String, int>? _times;
  Future<void>? _alreadyLoading;

  Future<Map<String, int>> getTimes() async {
    if (_alreadyLoading != null) await _alreadyLoading;
    Map<String, int>? _times = this._times;
    if (_times == null) {
      final futureBuilder = Completer<void>();
      this._alreadyLoading = futureBuilder.future;
      this._times = _times = await (() async {
        final Map<String, int> ret = {};
        final Database db = await database;
        List<Map> entries = await db
            .query(_tableHighscore, columns: [_columnLayout, _columnTime]);

        for (var entry in entries) {
          ret[entry[_columnLayout] as String] = entry[_columnTime] as int;
        }

        return ret;
      })();
      this._alreadyLoading = null;
      futureBuilder.complete();
    }
    return _times;
  }

  Future<void> set(String layout, int time) async {
    Database db = await database;
    if (_alreadyLoading != null) await _alreadyLoading;
    final _times = this._times;
    if (_times != null) {
      _times[layout] = time;
    }
    await db.insert(_tableHighscore, {_columnLayout: layout, _columnTime: time},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}

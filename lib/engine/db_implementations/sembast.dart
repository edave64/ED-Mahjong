import 'package:ed_mahjong/engine/highscore_storage.dart' show IHighscoreDB;
import 'package:ed_mahjong/engine/db_implementations/sembast/sembast.dart';
import 'package:sembast/sembast.dart';

class HighscoreSembast extends IHighscoreDB {
  final Future<Database> db;
  final store = StoreRef<String, int>.main();

  HighscoreSembast._() : db = getDatabaseFactory().openDatabase("highscores");
  static final HighscoreSembast instance = HighscoreSembast._();

  @override
  Future<Map<String, int>> getTimes() async {
    final records = await store.find(await db);
    final ret = new Map<String, int>();

    for (final record in records) {
      ret[record.key] = record.value;
    }

    return ret;
  }

  @override
  Future<void> set(String layout, int time) async {
    final db_ = await db;
    await db_.transaction((txn) async {
      final record = store.record(layout);
      if (await record.exists(db_)) {
        record.update(db_, time);
      } else {
        record.add(db_, time);
      }
    });
  }
}

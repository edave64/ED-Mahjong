import 'package:ed_mahjong/engine/highscore_storage.dart' show IHighscoreDB;

class HighscoreDummy extends IHighscoreDB {
  HighscoreDummy._();
  static final HighscoreDummy instance = HighscoreDummy._();

  @override
  Future<Map<String, int>> getTimes() {
    return Future.value({});
  }

  @override
  Future<void> set(String layout, int time) {
    return Future.value();
  }
}

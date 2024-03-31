import 'package:sembast/sembast.dart';
import 'package:sembast_sqflite/sembast_sqflite.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

DatabaseFactory getDatabaseFactory() =>
    getDatabaseFactorySqflite(sqflite.databaseFactory);

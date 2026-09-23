import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseHelper {
  late Database database;

  Future<void> initDatabase({
    required String databasePathName,
    int version = 1,
    FutureOr<void> Function(Database, int)? onCreate,
  }) async {
    database = await openYourDatabase(
      databasePathName: databasePathName,
      version: version,
      onCreate: onCreate,
    );
    print(database);
  }

  Future<Database> openYourDatabase({
    required String databasePathName,
    int version = 1,
    FutureOr<void> Function(Database, int)? onCreate,
  }) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "$databasePathName.db");
    return openDatabase(path, version: version, onCreate: onCreate);
  }

  Future<void> insertToDatabase({
    required Map<String, dynamic> values,
    required String tableName,
  }) async {
    await database.insert(
      tableName,
      values,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateDatabase({
    required Map<String, dynamic> values,
    required String tableName,
    required String query,
  }) async {
    await database.update(tableName, values, where: query);
  }

  Future<void> deleteDatabase({
    required String tableName,
    required String query,
  }) async {
    await database.delete(tableName, where: query);
  }

  Future<List<Map<String, dynamic>>> getData({
    required String tableName,
    String? where,
  }) async {
    return await database.query(tableName, where: where);
  }

  Future<void> execute({
    required String query,
    List<Object?>? arguments,
  }) async {
    await database.execute(query, arguments);
  }
}

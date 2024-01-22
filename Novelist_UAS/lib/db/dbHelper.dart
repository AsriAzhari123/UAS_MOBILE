import 'dart:io';

import 'package:apk1/models/novelModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DbHelper {
  late Database database;
  static DbHelper dbHelper = DbHelper();
  final String tableName = 'novelist';
  final String nameColumn = 'name';
  final String idColumn = 'id';
  final String isFavoriteColumn = 'isFavorite';
  final String genreColumn = 'genre';
  final String deskripsiColumn = 'deskripsi';
  final String halamanColumn = 'halaman';
  final String imageColumn = 'image';

  Future initDatabase() async {
    database = await connectToDatabase();
  }

  Future<Database> connectToDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/novel.db';
    return openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute(
          'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT, $halamanColumn INTEGER, $isFavoriteColumn INTEGER, $genreColumn TEXT, $deskripsiColumn TEXT, $imageColumn TEXT)');
    }, onUpgrade: (db, oldVersion, newVersion) {
      db.execute(
          'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT, $halamanColumn INTEGER, $isFavoriteColumn INTEGER, $genreColumn TEXT, $deskripsiColumn TEXT, $imageColumn TEXT)');
    }, onDowngrade: (db, oldVersion, newVersion) {
      db.delete(tableName);
    });
  }

  Future<List<NovelModel>> getAllNovel() async {
    List<Map<String, dynamic>> tasks = await database.query(tableName);
    return tasks.map((e) => NovelModel.fromMap(e)).toList();
  }

  // insert
  insertNewNovel(NovelModel novelModel) {
    database.insert(tableName, novelModel.toMap());
  }

  // delete by id
  deleteNovel(NovelModel novelModel) {
    database
        .delete(tableName, where: '$idColumn=?', whereArgs: [novelModel.id]);
  }

  // delete all
  deleteNovels() {
    database.delete(tableName);
  }

  // update
  updateNovel(NovelModel novelModel) async {
    await database.update(
        tableName,
        {
          isFavoriteColumn: novelModel.isFavorite ? 1 : 0,
          nameColumn: novelModel.name,
          halamanColumn: novelModel.halaman,
          imageColumn: novelModel.image,
          genreColumn: novelModel.genre,
          deskripsiColumn: novelModel.deskripsi,
        },
        where: '$idColumn=?',
        whereArgs: [novelModel.id]);
  }

  updateIsFavorite(NovelModel novelModel) {
    database.update(
        tableName, {isFavoriteColumn: !novelModel.isFavorite ? 1 : 0},
        where: '$idColumn=?', whereArgs: [novelModel.id]);
  }
}

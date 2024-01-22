import 'dart:io';
import 'package:apk1/db/dbHelper.dart';
import 'package:apk1/models/novelModel.dart';
import 'package:flutter/material.dart';


class NovelClass extends ChangeNotifier {
  NovelClass() {
    getNovels();
  }

  bool isDark = false;
  bool isLoading = false; // New loading state
  changeIsDark() {
    isDark = !isDark;
    notifyListeners();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController halamanController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  File? image;

  List<NovelModel> allNovels = [];
  List<NovelModel> favoriteNovels = [];

  getNovels() async {
    isLoading = true; // Set loading to true
    notifyListeners();

    allNovels = await DbHelper.dbHelper.getAllNovel();
    favoriteNovels = allNovels.where((e) => e.isFavorite).toList();

    isLoading = false; // Set loading to false after data is fetched
    notifyListeners();
  }

  insertNewNovel() {
    NovelModel novelModel = NovelModel(
        name: nameController.text,
        isFavorite: false,
        image: image,
        genre: genreController.text,
        deskripsi: deskripsiController.text,
        halaman: int.parse(
            halamanController.text != '' ? halamanController.text : '0'));
    DbHelper.dbHelper.insertNewNovel(novelModel);
    getNovels();
  }

  updateNovel(NovelModel novelModel) async {
    await DbHelper.dbHelper.updateNovel(novelModel);
    getNovels();
  }

  updateIsFavorite(NovelModel novelModel) {
    DbHelper.dbHelper.updateIsFavorite(novelModel);
    getNovels();
  }

  deleteNovel(NovelModel novelModel) {
    DbHelper.dbHelper.deleteNovel(novelModel);
    getNovels();
  }
}

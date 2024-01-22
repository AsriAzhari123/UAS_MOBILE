import 'package:apk1/db/httpHelper.dart';
import 'package:flutter/material.dart';



class MangaProvider extends ChangeNotifier {
  String _querys = "";
  ProxyServer? helper;

  List? _manga;
  List? _filteredManga;

  //getter
  String get querys => _querys;
  List? get manga => _manga;
  List? get filteredManga => _filteredManga;

  //setter
  set setQuerys(value) {
    if (value != null) {
      _querys = value;
      notifyListeners();
    }
  }

  set setManga(value) {
    if (value != null) {
      _manga = value;
      notifyListeners();
    }
  }

  set setFilteredManga(value) {
    if (value != null) {
      _filteredManga = value;
      notifyListeners();
    }
  }

  //search filter function
  void filterManga(String query) {
    _querys = query;
    _filteredManga = _manga
        ?.where((item) => item.title?['en'].toLowerCase().contains(query))
        .toList();
    notifyListeners();
  }

  //initialize data
  Future initialize() async {
    helper = ProxyServer();
    _manga = await helper?.getManga();
    _filteredManga = _manga;
    notifyListeners();
  }

  //running initialize()
  MangaProvider() {
    initialize();
  }
}

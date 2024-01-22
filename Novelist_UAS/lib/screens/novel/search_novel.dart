// ignore_for_file: must_be_immutable

import 'package:apk1/models/novelModel.dart';
import 'package:apk1/provider/ChangeLanguage.dart';
import 'package:apk1/widget/Novel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchNovelScreen extends StatefulWidget {
  final List<NovelModel> novels;
  List<NovelModel> filteredNovels = [];

  SearchNovelScreen({Key? key, required this.novels}) {
    filteredNovels = novels;
  }

  @override
  State<SearchNovelScreen> createState() => _SearchNovelScreenState();
}

class _SearchNovelScreenState extends State<SearchNovelScreen> {
  void filterNovels(String value) {
    setState(() {
      widget.filteredNovels = widget.novels
          .where(
              (novel) => novel.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            filterNovels(value);
          },
          decoration: InputDecoration(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            hintText: languageProvider.currentLocale.languageCode == 'en'
                ? "Search Novel"
                : (languageProvider.currentLocale.languageCode == 'id'
                    ? "Cari Novel"
                    : "Buscar Novela"),
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.cancel),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: widget.filteredNovels.isNotEmpty
            ? ListView.builder(
                itemCount: widget.filteredNovels.length,
                itemBuilder: (BuildContext context, int index) {
                  return NovelWidget(widget.filteredNovels[index]);
                },
              )
            : Center(
                child: Text(languageProvider.currentLocale.languageCode == 'en'
                    ? "Novel not found..."
                    : (languageProvider.currentLocale.languageCode == 'id'
                        ? "Novel tidak ditemukan..."
                        : "Novela no encontrada...")),
              ),
      ),
    );
  }
}

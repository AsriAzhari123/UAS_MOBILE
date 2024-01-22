import 'package:apk1/provider/ChangeLanguage.dart';
import 'package:apk1/provider/NovelProv.dart';
import 'package:apk1/provider/NovelistProvider.dart';
import 'package:apk1/widget/drawer.dart';
import 'package:apk1/widget/popUpMenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detailNovel.dart';

class MyNovelist extends StatefulWidget {
  const MyNovelist({super.key});

  @override
  State<MyNovelist> createState() => _MyNovelistState();
}

class _MyNovelistState extends State<MyNovelist> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<MangaProvider>(context);
    var novelProvider = Provider.of<NovelClass>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(languageProvider.currentLocale.languageCode == 'en'
            ? "MY NOVELIST"
            : (languageProvider.currentLocale.languageCode == 'id'
                ? "NOVELIS SAYA"
                : "MIS NOVELISTAS")),
        actions: [MyPopupMenuButton()],
        backgroundColor: novelProvider.isDark ? Colors.black : null,
      ),
      drawer: Drawer(
        backgroundColor: !novelProvider.isDark ? Colors.blue[200] : null,
        child: DrawerList(),
      ),
      body: Container(
        color: novelProvider.isDark ? Colors.black : null,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: languageProvider.currentLocale.languageCode == 'en'
                      ? "Search Manga"
                      : (languageProvider.currentLocale.languageCode == 'id'
                          ? "Cari Manga"
                          : "Buscar Manga"),
                  hintStyle: const TextStyle(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
                onTap: () {
                  FocusScope.of(context).unfocus();
                  TextEditingController().clear();
                },
                onChanged: (value) {
                  prov.filterManga(value);
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: (prov.filteredManga?.length == null)
                    ? 0
                    : prov.filteredManga?.length,
                itemBuilder: (BuildContext context, int position) {
                  final mangas = prov.filteredManga?[position];

                  return Card(
                    color:
                        novelProvider.isDark ? Colors.grey[800] : Colors.white,
                    elevation: 2.0,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailManga(mangas),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://wallpaperaccess.com/full/39033.png'),
                      ),
                      title: Text(
                        "${mangas.title[languageProvider.currentLocale.languageCode]}",
                        style: TextStyle(
                          color: novelProvider.isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        " ${mangas.year.toString()}",
                        style: TextStyle(
                          color: novelProvider.isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

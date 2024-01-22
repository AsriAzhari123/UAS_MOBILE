import 'package:apk1/provider/ChangeLanguage.dart';
import 'package:apk1/provider/NovelProv.dart';
import 'package:apk1/screens/novel/search_novel.dart';
import 'package:apk1/widget/Novel.dart';
import 'package:apk1/widget/drawer.dart';
import 'package:apk1/widget/popUpMenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritNovelScreen extends StatelessWidget {
  const FavoritNovelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final myProvider = Provider.of<NovelClass>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Consumer<NovelClass>(
      builder: (BuildContext context, myProvider, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(languageProvider.currentLocale.languageCode == 'en'
                    ? "My Favorite Novels"
                    : (languageProvider.currentLocale.languageCode == 'id'
                        ? "Novel Favorit Saya"
                        : "Mis Novelas Favoritas")),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "${myProvider.favoriteNovels.length} novels",
                  style: TextStyle(
                    fontSize: 16,
                    color: myProvider.isDark
                        ? Colors.white
                        : const Color.fromARGB(255, 244, 143, 177),
                  ),
                ),
              ],
            ),
            actions: [
              InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) =>
                        SearchNovelScreen(novels: myProvider.favoriteNovels)))),
                child: Icon(Icons.search),
              ),
              MyPopupMenuButton()
            ],
          ),
          drawer: Drawer(
            backgroundColor: !myProvider.isDark ? Colors.blue[200] : null,
            child: DrawerList(),
          ),
          body: myProvider.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : (myProvider.favoriteNovels.isEmpty
                  ? Center(
                      child: Text(
                        languageProvider.currentLocale.languageCode == 'en'
                            ? "You haven't marked any novels as favorites."
                            : (languageProvider.currentLocale.languageCode ==
                                    'id'
                                ? "Anda belum menandai novel sebagai favorit."
                                : "No has marcado ninguna novela como favorita."),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: myProvider.favoriteNovels.length,
                      itemBuilder: (context, index) {
                        return NovelWidget(myProvider.favoriteNovels[index]);
                      },
                    )),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:apk1/provider/NovelProv.dart';
import 'package:apk1/provider/ChangeLanguage.dart';
import 'package:apk1/screens/novel/search_novel.dart';
import 'package:apk1/widget/Novel.dart';
import 'package:apk1/widget/drawer.dart';
import 'package:apk1/widget/popUpMenu.dart';
import 'package:apk1/screens/novel/new_novel.dart';

class MainNovelScreen extends StatelessWidget {
  const MainNovelScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<NovelClass>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Consumer<NovelClass>(
      builder: (BuildContext context, myProvider, Widget? child) => Scaffold(
        appBar: AppBar(
          title: Text(languageProvider.currentLocale.languageCode == 'en'
              ? "ADD NOVELIST"
              : (languageProvider.currentLocale.languageCode == 'id'
                  ? "TAMBAHKAN PENULIS NOVEL"
                  : "AÑADIR NOVELISTA")),
          actions: [
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) =>
                      SearchNovelScreen(novels: myProvider.allNovels)),
                ),
              ),
              child: Icon(Icons.search),
            ),
            MyPopupMenuButton(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showInterstitialAd(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewNovelScreen(),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
        drawer: Drawer(
          backgroundColor: !myProvider.isDark ? Colors.blue[200] : null,
          child: DrawerList(),
        ),
        body: ListView.builder(
          itemCount: myProvider.allNovels.length,
          itemBuilder: (context, index) {
            return NovelWidget(myProvider.allNovels[index]);
          },
        ),
      ),
    );
  }

  void _showInterstitialAd(BuildContext context) {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          ad.show();
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }
}


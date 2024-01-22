import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:apk1/models/novelModel.dart';
import 'package:apk1/provider/NovelProv.dart';
import 'package:apk1/provider/ChangeLanguage.dart';
import 'edite_novel.dart';

class ShowNovelScreen extends StatelessWidget {
  final NovelModel novelModel;

  ShowNovelScreen({Key? key, required this.novelModel});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Consumer<NovelClass>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              InkWell(
                onTap: () {
                  provider.nameController.text = novelModel.name;
                  provider.halamanController.text =
                      novelModel.halaman.toString();
                  provider.genreController.text = novelModel.genre;
                  provider.deskripsiController.text = novelModel.deskripsi;
                  provider.image = novelModel.image;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditNovelScreen(novelModel: novelModel),
                    ),
                  );
                },
                child: Icon(Icons.edit),
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  provider.deleteNovel(novelModel);
                  Navigator.pop(context);
                },
                child: Icon(Icons.delete),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: !Provider.of<NovelClass>(context).isDark
                        ? Colors.blue
                        : null,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 178,
                  child: novelModel.image == null
                      ? Center(
                          child: CircleAvatar(
                            radius: 48,
                            backgroundImage: AssetImage('image/onepiece.png'),
                          ),
                        )
                      : Image.file(novelModel.image!),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    novelModel.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: !Provider.of<NovelClass>(context).isDark
                        ? Colors.blue[100]
                        : null,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Text(
                        languageProvider.currentLocale.languageCode == 'en'
                            ? "Pages :"
                            : (languageProvider.currentLocale.languageCode ==
                                    'id'
                                ? "Halaman :"
                                : "Páginas :"),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${novelModel.halaman} ${languageProvider.currentLocale.languageCode == 'en' ? "pages" : (languageProvider.currentLocale.languageCode == 'id' ? "lembar" : "hojas")}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: !Provider.of<NovelClass>(context).isDark
                        ? Colors.blue[100]
                        : null,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        languageProvider.currentLocale.languageCode == 'en'
                            ? "Genre :"
                            : (languageProvider.currentLocale.languageCode ==
                                    'id'
                                ? "Genre :"
                                : "Género :"),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        novelModel.genre,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: !Provider.of<NovelClass>(context).isDark
                        ? Colors.blue[100]
                        : null,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        languageProvider.currentLocale.languageCode == 'en'
                            ? "Description :"
                            : (languageProvider.currentLocale.languageCode ==
                                    'id'
                                ? "Deskripsi :"
                                : "Descripción :"),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        novelModel.deskripsi,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                // Banner Ad
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  height: 50, // Adjust the height as needed
                  child: AdWidget(
                    ad: BannerAd(
                      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
                      size: AdSize.banner,
                      request: AdRequest(),
                      listener: BannerAdListener(),
                    )..load(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

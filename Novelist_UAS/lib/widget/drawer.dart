// Import necessary packages
import 'package:apk1/provider/ChangeLanguage.dart';
import 'package:apk1/screens/novel/MyFireStore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:apk1/provider/NovelProv.dart';
import 'package:apk1/screens/signin_screen.dart';
import 'package:apk1/screens/novel/favorite_novel.dart';
import 'package:apk1/screens/novel/main-novel.dart';
import 'package:apk1/screens/novel/novelist.dart';

class DrawerList extends StatefulWidget {
  const DrawerList({Key? key}) : super(key: key);

  @override
  State<DrawerList> createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<NovelClass>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    User? user = FirebaseAuth.instance.currentUser;
    String userEmail = user?.email ?? "Guest";

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          color: myProvider.isDark ? Colors.blue : null,
          child: Stack(
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/onepiece.jpg'),
                  radius: 50,
                ),
              ),
              Positioned(
                bottom: 10,
                left: MediaQuery.of(context).size.width / 2 -
                    (userEmail.length * 5.0),
                child: Text(
                  userEmail,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Text(languageProvider.currentLocale.languageCode == 'en'
              ? "Home"
              : (languageProvider.currentLocale.languageCode == 'id'
                  ? "Beranda"
                  : "Inicio")),
          leading: Icon(Icons.home, color: Colors.black),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainNovelScreen(),
              ),
            );
          },
        ),
        const Divider(
          thickness: 1,
        ),
        ListTile(
          title: Text(languageProvider.currentLocale.languageCode == 'en'
              ? "Favorite Novel"
              : (languageProvider.currentLocale.languageCode == 'id'
                  ? "Novel Favorit"
                  : "Novela Favorita")),
          leading: Icon(Icons.favorite, color: Colors.red),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => FavoritNovelScreen(),
              ),
            );
          },
        ),
        const Divider(
          thickness: 1,
        ),
        ListTile(
          title: Text(languageProvider.currentLocale.languageCode == 'en'
              ? "Novel List"
              : (languageProvider.currentLocale.languageCode == 'id'
                  ? "Daftar Novel"
                  : "Lista de Novelas")),
          leading: Icon(Icons.book_online, color: Colors.black),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyNovelist(),
              ),
            );
          },
        ),
        const Divider(
          thickness: 1,
        ),
        SwitchListTile(
          title: Text(myProvider.isDark
              ? languageProvider.currentLocale.languageCode == 'en'
                  ? "Light Mode"
                  : (languageProvider.currentLocale.languageCode == 'id'
                      ? "Mode Terang"
                      : "Modo Claro")
              : languageProvider.currentLocale.languageCode == 'en'
                  ? "Dark Mode"
                  : (languageProvider.currentLocale.languageCode == 'id'
                      ? "Mode Gelap"
                      : "Modo Oscuro")),
          value: myProvider.isDark,
          secondary: myProvider.isDark
              ? Icon(Icons.light_mode_outlined, color: Colors.black)
              : Icon(Icons.dark_mode_outlined, color: Colors.black),
          onChanged: (value) {
            myProvider.changeIsDark();
          },
        ),
        const Divider(
          thickness: 1,
        ),
        ListTile(
          title: Text(languageProvider.currentLocale.languageCode == 'en'
              ? "FireStore"
              : (languageProvider.currentLocale.languageCode == 'id'
                  ? "FireStore"
                  : "FireStore")),
          leading: Icon(Icons.storage, color: Colors.black),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => FirestoreScreen(),
              ),
            );
          },
        ),
        const Divider(
          thickness: 1,
        ),
        ListTile(
          title: Text(languageProvider.currentLocale.languageCode == 'en'
              ? "Logout"
              : (languageProvider.currentLocale.languageCode == 'id'
                  ? "Keluar"
                  : "Cerrar sesión")),
          leading: Icon(Icons.exit_to_app, color: Colors.black),
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    languageProvider.currentLocale.languageCode == 'en'
                        ? 'Logout Successful'
                        : (languageProvider.currentLocale.languageCode == 'id'
                            ? 'Berhasil Keluar'
                            : 'Cerrar sesión exitosa')),
                duration: Duration(seconds: 2),
              ),
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => SignInScreen(),
              ),
              (route) => false,
            );
          },
        ),
      ],
    );
  }
}

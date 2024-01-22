import 'dart:io';

import 'package:apk1/provider/ChangeLanguage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPopupMenuButton extends StatefulWidget {
  const MyPopupMenuButton({Key? key}) : super(key: key);

  @override
  State<MyPopupMenuButton> createState() => _MyPopupMenuButtonState();
}

class _MyPopupMenuButtonState extends State<MyPopupMenuButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (BuildContext context, languageProvider, Widget? child) =>
          PopupMenuButton(
        color: languageProvider.isDarkMode ? Colors.blue[200] : null,
        itemBuilder: (context) => [
          PopupMenuItem(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Text(
              languageProvider.currentLocale.languageCode == 'en'
                  ? "Open Menu"
                  : (languageProvider.currentLocale.languageCode == 'id'
                      ? "Buka Menu"
                      : "Abrir menú"),
            ),
          ),
          PopupMenuItem(
            child: Text(
              languageProvider.currentLocale.languageCode == 'en'
                  ? "About"
                  : (languageProvider.currentLocale.languageCode == 'id'
                      ? "Tentang"
                      : "Acerca de"),
            ),
          ),
          PopupMenuItem(
            onTap: () => _showLanguageDialog(context, languageProvider),
            child: Text(
              languageProvider.currentLocale.languageCode == 'en'
                  ? "Change Language"
                  : (languageProvider.currentLocale.languageCode == 'id'
                      ? "Ubah Bahasa"
                      : "Cambiar idioma"),
            ),
          ),
          PopupMenuItem(
            onTap: () {
              languageProvider.isDarkMode = !languageProvider.isDarkMode;
            },
            child: Row(
              children: [
                Icon(Icons.dark_mode),
                const SizedBox(width: 10),
                Text(
                  languageProvider.currentLocale.languageCode == 'en'
                      ? "Dark Mode"
                      : (languageProvider.currentLocale.languageCode == 'id'
                          ? "Mode Gelap"
                          : "Modo oscuro"),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            onTap: () {
              // Handle other menu item actions if needed
              exit(0);
            },
            child: Column(
              children: [
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(
                      Icons.exit_to_app_outlined,
                      color: Colors.red,
                    ),
                    SizedBox(width: 10),
                    Text(
                      languageProvider.currentLocale.languageCode == 'en'
                          ? "Exit"
                          : (languageProvider.currentLocale.languageCode == 'id'
                              ? "Keluar"
                              : "Salir"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(
      BuildContext context, LanguageProvider languageProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Column(
            children: languageProvider.supportedLocales
                .map((locale) => ListTile(
                      title: Text(locale.languageCode),
                      onTap: () {
                        languageProvider.currentLocale = locale;
                        Navigator.pop(context); // Close the dialog
                      },
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}

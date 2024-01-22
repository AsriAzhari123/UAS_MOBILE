import 'package:apk1/db/dbHelper.dart';
import 'package:apk1/provider/ChangeLanguage.dart';
import 'package:apk1/provider/NovelProv.dart';
import 'package:apk1/provider/NovelistProvider.dart';
import 'package:apk1/screens/novel/favorite_novel.dart';
import 'package:apk1/screens/novel/main-novel.dart';
import 'package:apk1/screens/novel/new_novel.dart';
import 'package:apk1/screens/novel/novelist.dart';
import 'package:apk1/screens/novel/splash_screen.dart';
import 'package:apk1/screens/signin_screen.dart';
import 'package:apk1/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.dbHelper.initDatabase();
  await Firebase.initializeApp();

  // Initialize local notifications
  await initializeLocalNotifications();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<NovelClass>(create: (context) => NovelClass()),
        ChangeNotifierProvider<MangaProvider>(create: (context) => MangaProvider()),
        ChangeNotifierProvider<LanguageProvider>(create: (context) => LanguageProvider()),
      ],
      child: const InitApp(),
    ),
  );
}

class InitApp extends StatelessWidget {
  const InitApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: languageProvider.isDarkMode
              ? ThemeData.dark()
              : ThemeData(
                  primarySwatch: Colors.blue,
                  scaffoldBackgroundColor: Colors.blue[200],
                  dialogBackgroundColor: Colors.blue[200],
                  primaryColor: Colors.blue[200],
                ),
          title: 'Novelist',
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            '/login': (context) => const SignInScreen(),
            '/register': (context) => const SignUpScreen(),
            '/favorite_novel_screen': (context) => const FavoritNovelScreen(),
            '/new_novel_screen': (context) => const NewNovelScreen(),
            '/main_novel_screen': (context) => const MainNovelScreen(),
            '/novelist': (context) => const MyNovelist(),
          },
        );
      },
    );
  }
}

// Initialize the local notification plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Function to initialize local notifications
Future<void> initializeLocalNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
}

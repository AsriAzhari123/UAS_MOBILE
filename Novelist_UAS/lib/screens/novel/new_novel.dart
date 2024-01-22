import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:apk1/provider/NovelProv.dart';
import 'package:apk1/provider/ChangeLanguage.dart'; // Import LanguageProvider
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // Import FlutterLocalNotificationsPlugin

class NewNovelScreen extends StatefulWidget {
  const NewNovelScreen({Key? key}) : super(key: key);

  @override
  _NewNovelScreenState createState() => _NewNovelScreenState();
}

class _NewNovelScreenState extends State<NewNovelScreen> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); // Initialize local notification plugin

  // Request camera permission
  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      status = await Permission.camera.request();
      if (status.isDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Camera permission is required to take pictures."),
          ),
        );
      }
    }
  }

  // Request gallery permission
  Future<void> requestGalleryPermission() async {
    var status = await Permission.photos.status;
    if (status.isDenied) {
      status = await Permission.photos.request();
      if (status.isDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text("Gallery permission is required to select pictures."),
          ),
        );
      }
    }
  }

  Future pickImage(BuildContext context, ImageSource source) async {
    // Request permission before picking image
    if (source == ImageSource.camera) {
      await requestCameraPermission();
    } else if (source == ImageSource.gallery) {
      await requestGalleryPermission();
    }

    // Proceed to pick image if permission is granted
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    Provider.of<NovelClass>(context, listen: false).image = File(image.path);
    setState(() {});
  }

  // Function to show local notification
  Future<void> _showLocalNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'novel_added_channel',
      'Novel Added',
      
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'Novel Added', // Notification title
      'A new novel has been added!', // Notification body
      platformChannelSpecifics,
    );
  }

  @override
  void initState() {
    super.initState();
    // Initialize local notifications in initState
    initializeLocalNotifications();
  }

  // Initialize local notifications
  Future<void> initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NovelClass>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          languageProvider.currentLocale.languageCode == 'en'
              ? "Add New Novel"
              : (languageProvider.currentLocale.languageCode == 'id'
                  ? "Tambahkan Novel Baru"
                  : "Añadir Nueva Novela"),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              TextField(
                controller: provider.nameController,
                decoration: InputDecoration(
                  labelText: languageProvider.currentLocale.languageCode == 'en'
                      ? "Novel Name"
                      : (languageProvider.currentLocale.languageCode == 'id'
                          ? "Nama Novel"
                          : "Nombre de la Novela"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                controller: provider.halamanController,
                decoration: InputDecoration(
                  labelText: languageProvider.currentLocale.languageCode == 'en'
                      ? "Halaman : (Lembar)"
                      : (languageProvider.currentLocale.languageCode == 'id'
                          ? "Halaman : (Lembar)"
                          : "Páginas : (Hojas)"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  PopupMenuButton(
                    color: !provider.isDark ? Colors.blue[100] : null,
                    itemBuilder: ((context) => [
                          PopupMenuItem(
                            onTap: () => pickImage(context, ImageSource.camera),
                            child: Row(
                              children: [
                                Icon(Icons.camera_alt_outlined),
                                SizedBox(width: 5),
                                Text(
                                  languageProvider.currentLocale.languageCode ==
                                          'en'
                                      ? "Take a picture"
                                      : (languageProvider
                                                  .currentLocale.languageCode ==
                                              'id'
                                          ? "Ambil Foto"
                                          : "Tomar una Foto"),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () =>
                                pickImage(context, ImageSource.gallery),
                            child: Row(
                              children: [
                                Icon(Icons.image_outlined),
                                SizedBox(width: 5),
                                Text(
                                  languageProvider.currentLocale.languageCode ==
                                          'en'
                                      ? "Select a picture"
                                      : (languageProvider
                                                  .currentLocale.languageCode ==
                                              'id'
                                          ? "Pilih Foto"
                                          : "Seleccionar una Foto"),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                  Text(
                    languageProvider.currentLocale.languageCode == 'en'
                        ? "ADD A PICTURE"
                        : (languageProvider.currentLocale.languageCode == 'id'
                            ? "TAMBAHKAN FOTO"
                            : "AGREGAR UNA IMAGEN"),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Visibility(
                visible: provider.image != null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        provider.image = null;
                        setState(() {});
                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        color: Colors.red,
                      ),
                    ),
                    if (provider.image != null)
                      Image.file(
                        provider.image!,
                        width: 100,
                        height: 100,
                      )
                    else
                      Container(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  height: 100,
                  child: TextField(
                    expands: true,
                    maxLines: null,
                    controller: provider.deskripsiController,
                    decoration: InputDecoration(
                      labelText: languageProvider.currentLocale.languageCode ==
                              'en'
                          ? "Deskripsi"
                          : (languageProvider.currentLocale.languageCode == 'id'
                              ? "Deskripsi"
                              : "Descripción"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  height: 100,
                  child: TextField(
                    expands: true,
                    maxLines: null,
                    controller: provider.genreController,
                    decoration: InputDecoration(
                      labelText: languageProvider.currentLocale.languageCode ==
                              'en'
                          ? "Genre"
                          : (languageProvider.currentLocale.languageCode == 'id'
                              ? "Genre"
                              : "Género"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (provider.nameController.text.isNotEmpty &&
                      provider.halamanController.text.isNotEmpty) {
                    provider.insertNewNovel();

                    // Trigger local notification after successful addition
                    _showLocalNotification();

                    // Clear input fields and navigate back
                    provider.nameController.clear();
                    provider.halamanController.clear();
                    provider.deskripsiController.clear();
                    provider.genreController.clear();
                    provider.image = null;
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          languageProvider.currentLocale.languageCode == 'en'
                              ? "Please fill in required fields."
                              : (languageProvider.currentLocale.languageCode ==
                                      'id'
                                  ? "Harap isi kolom yang diperlukan."
                                  : "Por favor, complete los campos requeridos."),
                        ),
                      ),
                    );
                  }
                },
                child: Center(
                  child: Text(
                    languageProvider.currentLocale.languageCode == 'en'
                        ? "Save Novel"
                        : (languageProvider.currentLocale.languageCode == 'id'
                            ? "Simpan Novel"
                            : "Guardar Novela"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

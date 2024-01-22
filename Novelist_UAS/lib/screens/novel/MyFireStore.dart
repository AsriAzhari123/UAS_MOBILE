import 'dart:convert';
import 'dart:math';
import 'package:apk1/models/firestore.dart';
import 'package:apk1/provider/NovelProv.dart';
import 'package:apk1/widget/drawer.dart';
import 'package:apk1/widget/popUpMenu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirestoreScreen extends StatefulWidget {
  const FirestoreScreen({super.key});

  @override
  State<FirestoreScreen> createState() => _FirestoreScreenState();
}

class _FirestoreScreenState extends State<FirestoreScreen> {
  List<EventModel> details = [];

  @override
  void initState() {
    readData();
    super.initState();
  }

  Future testData() async {
    await Firebase.initializeApp();
    print('init done');
    FirebaseFirestore db = FirebaseFirestore.instance;
    print('init Firestore Done');

    // ignore: unused_local_variable
    var data = await db.collection('novel').get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }

  Future readData() async {
    await Firebase.initializeApp();
    FirebaseFirestore db = FirebaseFirestore.instance;
    var data = await db.collection('novel').get();
    setState(() {
      details =
          data.docs.map((doc) => EventModel.fromDocSnapshot(doc)).toList();
    });
  }

  addRand() async {
    await Firebase.initializeApp();
    FirebaseFirestore db = FirebaseFirestore.instance;
    String getRandString(int len) {
      var random = Random.secure();
      var values = List<int>.generate(len, (i) => random.nextInt(255));
      return base64UrlEncode(values);
    }

    EventModel InsertData = EventModel(
        judul: getRandString(5),
        keterangan: getRandString(30),
        tanggal: getRandString(10),
        islike: Random().nextBool(),
        author: getRandString(20));
    await db.collection("novel").add(InsertData.toMap());
    setState(() {
      details.add(InsertData);
    });
  }

  deleteLast(String documentId) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection("novel").doc(documentId).delete();
    setState(() {
      details.removeLast();
    });
  }

  updateEvent(int pos) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db
        .collection("novel")
        .doc(details[pos].id)
        .update({'islike': !details[pos].islike});
    setState(() {
      details[pos].islike = !details[pos].islike;
    });
  }

  @override
  Widget build(BuildContext context) {
    testData();
    return Consumer<NovelClass>(
      builder: (BuildContext context, myProvider, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Cloud Firestore"),
                const SizedBox(
                  height: 4,
                ),
              ],
            ),
            actions: [MyPopupMenuButton()],
          ),
          drawer: Drawer(
            backgroundColor: !myProvider.isDark ? Colors.blue[200] : null,
            child: DrawerList(),
          ),
          body: ListView.builder(
            // ignore: unnecessary_null_comparison
            itemCount: (details != null) ? details.length : 0,
            itemBuilder: (context, position) {
              return CheckboxListTile(
                onChanged: (bool? value) {
                  updateEvent(position);
                },
                value: details[position].islike,
                title: Text(details[position].judul),
                subtitle: Text(
                  "${details[position].keterangan}\nHari : ${details[position].tanggal}\nauthor : ${details[position].author}",
                ),
                isThreeLine: false,
              );
            },
          ),
          floatingActionButton: FabCircularMenuPlus(children: <Widget>[
            IconButton(
              onPressed: () async {
                await addRand();
              },
              icon: const Icon(Icons.add),
            ),
            IconButton(
              onPressed: () async {
                if (details.last.id != null) {
                  await deleteLast(details.last.id!);
                }
              },
              icon: const Icon(Icons.minimize),
            ),
          ]),
        );
      },
    );
  }
}

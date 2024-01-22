import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? id;
  String judul;
  String keterangan;
  String tanggal;
  bool islike;
  String author;

  EventModel({
    this.id,
    required this.judul,
    required this.keterangan,
    required this.tanggal,
    required this.islike,
    required this.author,
  });

  Map<String, dynamic> toMap() {
    return {
      'judul': judul,
      'keterangan': keterangan,
      'author': author,
      'islike': islike,
      'tanggal': tanggal,
    };
  }

  EventModel.fromDocSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        judul = doc.data()?['judul'] ?? '',
        keterangan = doc.data()?['keterangan'] ?? '',
        author = doc.data()?['author'] ?? '',
        islike = doc.data()?['islike'] ?? false,
        tanggal = doc.data()?['tanggal'] ?? '';
}

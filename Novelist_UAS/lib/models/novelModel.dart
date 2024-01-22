import 'dart:io';

class NovelModel {
  int? id;
  late String name;
  late bool isFavorite;
  File? image;
  late int halaman;
  late String genre;
  late String deskripsi;

  NovelModel({
    this.id,
    required this.name,
    required this.isFavorite,
    this.image,
    required this.halaman,
    required this.genre,
    required this.deskripsi,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isFavorite': isFavorite ? 1 : 0,
      'halaman': halaman,
      'genre': genre,
      'deskripsi': deskripsi,
      'image': image == null ? '' : image!.path,
    };
  }

  factory NovelModel.fromMap(Map<String, dynamic> map) {
    return NovelModel(
      id: map['id'],
      name: map['name'],
      isFavorite: map['isFavorite'] == 1 ? true : false,
      halaman: map['halaman'],
      genre: map['genre'],
      deskripsi: map['deskripsi'],
      image: map['image'] != null ? File(map['image']) : null,
    );
  }

  // Add a method to update the data
  void updateData({
    required String newName,
    required bool newIsFavorite,
    required File? newImage,
    required int newHalaman,
    required String newGenre,
    required String newDeskripsi,
  }) {
    name = newName;
    isFavorite = newIsFavorite;
    image = newImage;
    halaman = newHalaman;
    genre = newGenre;
    deskripsi = newDeskripsi;
  }
}

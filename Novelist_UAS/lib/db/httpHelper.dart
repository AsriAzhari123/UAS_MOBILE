import 'dart:convert';
import 'package:apk1/models/novelist.dart';
import 'package:http/http.dart' as http;



class ProxyServer {
  final String apiUrl = 'https://api.mangadex.org/manga';

  Future<List?> getManga() async {
    final Uri url = Uri.parse(apiUrl);
    final http.Response result = await http.get(url);

    if (result.statusCode == 200) {
      final jsonResponse = json.decode(result.body);
      final mangaMap = jsonResponse['data'];
      List attr = mangaMap.map((i) => i['attributes']).toList();
      List mangas = attr.map((e) => Manga.fromJson(e)).toList();
      // print(mangas);
      return mangas;
    } else {
      return null;
    }
  }
}

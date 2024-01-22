import 'package:apk1/models/novelist.dart';
import 'package:flutter/material.dart';



class DetailManga extends StatelessWidget {
  const DetailManga(this.manga, {Key? key}) : super(key: key);
  final Manga manga;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(manga.title?['en']),
      ),
      body: FutureBuilder(
        future:
            fetchData(), // Replace fetchData() with the function that fetches your data
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While data is being loaded
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // If there's an error
            return Center(
              child: Text('Error loading data'),
            );
          } else {
            // If data has been loaded successfully
            double height = MediaQuery.of(context).size.height;
            String path = 'https://wallpaperaccess.com/full/39033.png';

            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(16),
                      height: height / 1.5,
                      child: Image.network(path),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Text(manga.description?['en']),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> fetchData() async {
    // Simulate fetching data with a delay
    await Future.delayed(Duration(seconds: 2));
    // Replace this with the actual function that fetches your data
  }
}

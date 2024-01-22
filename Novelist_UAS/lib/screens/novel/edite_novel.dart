import 'dart:io';
import 'package:apk1/models/novelModel.dart';
import 'package:apk1/provider/NovelProv.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



import 'package:provider/provider.dart';

class EditNovelScreen extends StatefulWidget {
  final NovelModel novelModel;

  EditNovelScreen({Key? key, required this.novelModel});

  @override
  State<EditNovelScreen> createState() => _EditNovelScreenState();
}

class _EditNovelScreenState extends State<EditNovelScreen> {
  Future<void> pickImage(BuildContext context, ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    Provider.of<NovelClass>(context, listen: false).image = File(image.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NovelClass>(context, listen: false);

    provider.nameController.text = widget.novelModel.name;
    provider.halamanController.text = widget.novelModel.halaman.toString();
    provider.genreController.text = widget.novelModel.genre;
    provider.deskripsiController.text = widget.novelModel.deskripsi;
    provider.image = widget.novelModel.image;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Novel"),
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
                  labelText: "Novel Name",
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
                  labelText: "Halaman (Lembar)",
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
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: () => pickImage(context, ImageSource.camera),
                        child: Row(
                          children: const [
                            Icon(Icons.camera_alt_outlined),
                            SizedBox(width: 5),
                            Text("Take a picture"),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () => pickImage(context, ImageSource.gallery),
                        child: Row(
                          children: const [
                            Icon(Icons.image_outlined),
                            SizedBox(width: 5),
                            Text("Select a picture"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "ADD PICTURE",
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
                      child: const Icon(
                        Icons.cancel_outlined,
                        color: Colors.red,
                      ),
                    ),
                    if (provider.image != null)
                      Image.file(
                        provider.image!,
                        width: 100,
                        height: 100,
                      ),
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
                    controller: provider.genreController,
                    decoration: InputDecoration(
                      labelText: "Genre",
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
                    controller: provider.deskripsiController,
                    decoration: InputDecoration(
                      labelText: "Deskripsi",
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
                  widget.novelModel.name = provider.nameController.text;
                  widget.novelModel.halaman = int.parse(
                    provider.halamanController.text.isNotEmpty
                        ? provider.halamanController.text
                        : '0',
                  );
                  widget.novelModel.image = provider.image;
                  widget.novelModel.genre = provider.genreController.text;
                  widget.novelModel.deskripsi =
                      provider.deskripsiController.text;

                  // Assuming you have a method to save the changes
                  // e.g., provider.saveNovel(widget.novelModel);

                  // Navigate back to the previous screen
                  Navigator.of(context).pop();
                },
                child: const Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

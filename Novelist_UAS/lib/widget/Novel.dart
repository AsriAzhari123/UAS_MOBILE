import 'package:apk1/models/novelModel.dart';
import 'package:apk1/provider/NovelProv.dart';
import 'package:apk1/screens/novel/show_novel.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


class NovelWidget extends StatelessWidget {
  final NovelModel novelModel;

  NovelWidget(this.novelModel, {Key? key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowNovelScreen(novelModel: novelModel),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        child: ListTile(
          tileColor: !Provider.of<NovelClass>(context).isDark
              ? Colors.blue[100]
              : null,
          leading: novelModel.image == null
              ? Container(
                  decoration: BoxDecoration(
                    color: !Provider.of<NovelClass>(context).isDark
                        ? Colors.blue
                        : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: double.infinity,
                  width: 70,
                  child: const Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('image/onepiece.png'),
                    ),
                  ),
                )
              : Image.file(
                  novelModel.image!,
                  width: 70,
                  height: double.infinity,
                ),
          title: Text(novelModel.name),
          subtitle: Text('${novelModel.halaman} lembar'),
          trailing: InkWell(
            onTap: () {
              Provider.of<NovelClass>(context, listen: false)
                  .updateIsFavorite(novelModel);
            },
            child: novelModel.isFavorite
                ? const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : const Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
          ),
        ),
      ),
    );
  }
}

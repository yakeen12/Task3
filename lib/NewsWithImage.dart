import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:task3/ArticlePage.dart';
import 'package:task3/model/article_model.dart';

class NewsWithImageItem {
  final String? Title;
  final String? ImagrUrl;

  NewsWithImageItem({required this.Title, required this.ImagrUrl});
}

class NewsWithImage extends StatelessWidget {
  final NewsWithImageItem item;

  NewsWithImage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ItemPage")),
      body: Column(children: []),
    );
  }
}

Widget buildNewsWithImage(
    {required NewsWithImageItem item,
    required Article a,
    required BuildContext context}) {
  Widget urlImageExists() {
    if (a.urlToImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          a.urlToImage ?? "",
          height: 150,
          width: 200,
          fit: BoxFit.fill,
        ),
      );
    }

    return SizedBox(
      height: 12,
    );
  }

  return RawMaterialButton(
    onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ArticlePage(
                    article: a,
                  )));
    },
    child: Container(
        width: 200,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
            child: Stack(
          children: [
            Positioned(
              top: 0,
              child: urlImageExists(),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                height: 50,
                width: 200,
                color: Color.fromARGB(255, 227, 226, 226),
                child: Text(
                  item.Title ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Color.fromARGB(135, 2, 2, 2)),
                ),
              ),
            )
          ],
        ))),
  );
}

import 'package:flutter/material.dart';
import 'package:task3/model/article_model.dart';

//Text(article!.title ?? ""),

class ArticlePage extends StatelessWidget {
  final Article? article;

  ArticlePage({this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 160, 192),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.share_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.bookmark_outline)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
                  child: Text(
                    article!.publishedAt ?? "",
                    style: TextStyle(
                      color: Color.fromARGB(255, 178, 175, 175),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(children: [
                Text(
                  article!.title ?? "",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  article!.author ?? "",
                  style: TextStyle(
                      color: Color.fromARGB(255, 178, 175, 175),
                      fontWeight: FontWeight.bold),
                ),
                urlImageExists()
              ]),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(article!.description ?? ""),
                  SizedBox(
                    height: 20,
                  ),
                  Text(article!.content ?? ""),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget urlImageExists() {
    if (article!.urlToImage != null) {
      return Image.network(
        article!.urlToImage ?? "",
        height: 400,
        width: 400,
      );
    }
    return SizedBox(
      height: 12,
    );
  }
}

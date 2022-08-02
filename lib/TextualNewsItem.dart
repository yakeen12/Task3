import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:task3/model/article_model.dart';
import 'package:task3/ArticlePage.dart';

class TextualNewsItem {
  final String? Title;
  final String? PublishDate;

  TextualNewsItem({required this.Title, required this.PublishDate});
}

class TextualNews extends StatelessWidget {
  final TextualNewsItem item;

  TextualNews({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ItemPage")),
      body: Column(children: []),
    );
  }
}

Widget buildTextualNews(
    {required TextualNewsItem item,
    required Article a,
    required BuildContext context}) {
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
      padding: EdgeInsets.all(20),
      width: 320,
      height: 270,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 160, 192),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.Title ?? "",
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 7,
          ),
          Text(item.PublishDate ?? "", style: TextStyle(color: Colors.white))
        ],
      ),
    ),
  );
}

import 'package:flutter/material.dart';

import 'NewsWithImage.dart';
import 'model/article_model.dart';

class SeeAllAroundTheWorldPage extends StatelessWidget {
  final Future<List<Article>> future;
  final Future<List<Article>> futureWithPic;

  const SeeAllAroundTheWorldPage(
      {Key? key, required this.future, required this.futureWithPic})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Around the world"), backgroundColor: Color.fromARGB(255, 255, 160, 192),),
      body: Container(
        child: FutureBuilder(
          future: futureWithPic,
          builder:
              (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
            if (snapshot.hasData) {
              List<Article>? articles = snapshot.data;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: articles!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(12, 12, 0, 0),
                    child: buildNewsWithImage(
                        item: NewsWithImageItem(
                            Title: articles[index].title,
                            ImagrUrl: articles[index].urlToImage),
                        a: articles[index],
                        context: context),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

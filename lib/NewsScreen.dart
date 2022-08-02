import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task3/NewsWithImage.dart';
import 'package:task3/model/article_model.dart';
import 'package:task3/services/api_service.dart';
import 'TextualNewsItem.dart';
import 'SeeAllAroundTheWorldPage.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

ApiService client = ApiService();

class _NewsScreenState extends State<NewsScreen> {
  List<String> buttonsTexts = [
    "All",
    "Sport",
    "Entertainment",
    "Science",
    "technology"
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Container> containers = [
      newsBody(client.get('general'), client.getWithPic('general'), context),
      newsBody(client.get('sport'), client.getWithPic('sport'), context),
      newsBody(client.get('entertainment'), client.getWithPic('entertainment'),
          context),
      newsBody(client.get('science'), client.getWithPic('science'), context),
      newsBody(
          client.get('technology'), client.getWithPic('technology'), context),
    ];

    return Scaffold(
      //backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 0, 20),
            height: 47,
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(0, 5, 7, 5),
              scrollDirection: Axis.horizontal,
              itemCount: buttonsTexts.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 17,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      shape: StadiumBorder(),
                      primary: (_selectedIndex == index)
                          ? Color.fromARGB(255, 255, 160, 192)
                          : Color.fromARGB(255, 222, 218, 218),
                    ),
                    child: Text(
                      buttonsTexts[index],
                      style: TextStyle(
                          fontSize: (_selectedIndex == index) ? 20 : 16),
                    ),
                    onPressed: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    });
              },
            ),
          ),
          containers[_selectedIndex]
        ]),
      ),
    );
  }
}

Container newsBody(Future<List<Article>> future,
    Future<List<Article>> futureWithPic, BuildContext context) {
  return Container(
    height: 700,
    alignment: Alignment.topLeft,
    padding: EdgeInsets.only(left: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Latest news",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 300,
          child: FutureBuilder(
            future: future,
            builder:
                (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
              if (snapshot.hasData) {
                List<Article>? articles = snapshot.data;
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 12,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return buildTextualNews(
                        item: TextualNewsItem(
                          Title: articles![index].title,
                          PublishDate: articles[index].publishedAt,
                        ),
                        a: articles[index],
                        context: context);
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Around the world",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context, ) => SeeAllAroundTheWorldPage(future: future, futureWithPic: futureWithPic,)));
                },
                child: Text("See all",
                    style: TextStyle(fontSize: 20, color: Colors.black38)),
              )
            ],
          ),
        ),
        Container(
          height: 170,
          child: FutureBuilder(
            future: futureWithPic,
            builder:
                (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
              if (snapshot.hasData) {
                List<Article>? articles = snapshot.data;
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 14,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return buildNewsWithImage(
                        item: NewsWithImageItem(
                            Title: articles![index].title,
                            ImagrUrl: articles[index].urlToImage),
                        a: articles[index],
                        context: context);
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ],
    ),
  );
}

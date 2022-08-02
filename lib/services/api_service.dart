import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task3/model/article_model.dart';

class ApiService {
  final endPointUrl = "newsapi.org";
  final client = http.Client();

  Future<List<Article>> getWithPic(String category) async {
    final queryParameters = {
      'country': 'us',
      'category': category,
      'apiKey': '3b03ce0283cc4e85a66cb087c3921e3f'
    };
    final uri = Uri.https(endPointUrl, '/v2/top-headlines', queryParameters);
    final response = await client.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> body = json['articles'];
    List<Article> articles =
        body.map((dynamic item) => Article.fromJson(item)).toList();
    return articles;
  }

  Future<List<Article>> get(String category) async {
    final queryParameters = {
      'country': 'eg',
      'category': category,
      'apiKey': '6fff9e3242d9456f81c2e65d4fc1f8b6'
    };
    final uri = Uri.https(endPointUrl, '/v2/top-headlines', queryParameters);
    final response = await client.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> body = json['articles'];
    List<Article> articles =
        body.map((dynamic item) => Article.fromJson(item)).toList();
    return articles;
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/moudel/article.dart';
import 'package:news_app/screen/home_screen.dart';

class Newsapiservice {
  const Newsapiservice({required this.client});
  final http.Client client;
  Future<List<Article>> searchArticles(String query) async {
    final uri = Uri.https("gnews.io", "/api/v4/search", {
      "q": query,
      "apikey": "",
      "lang": "en",
      "max": "10",
    });

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> articlesJson = jsonData["articles"];
      return articlesJson
          .map((e) => Article.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
        print("Status code: ${response.statusCode}");
      print("Body: ${response.body}");
      throw Exception("Failed to load news");
    }
  }
    Future<List<Article>> changeLung(String query) async {
    final uri = Uri.https("gnews.io", "/api/v4/search", {
      "q": "None",
      "apikey": "",
      "lang": query,
      "country": "Any",
      "max": "10",
    });

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> articlesJson = jsonData["articles"];
      return articlesJson
          .map((e) => Article.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception("Failed to load news");
    }
  }

  Future<List<Article>> featchArticle() async {
    final uri = Uri.tryParse(
    );
    try {
      final response = await client.get(uri!);
      if (response.statusCode == 200) {
        final jsondata = jsonDecode(response.body);
        final List<dynamic> article = jsondata["articles"];
        return article
            .map((e) => Article.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception("Failed to load news");
      }
    } catch (e) {
      logger.e(e);
      return [];
    }
  }
}

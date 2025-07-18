import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/moudel/article.dart';
import 'package:news_app/screen/home_screen.dart';

class Newsapiservice {
  Newsapiservice ({required this.client}) : apiKey = dotenv.env['API_KEY']!;
  final http.Client client;
  final String apiKey;

  Future<List<Article>> searchArticles(String query) async {
    final uri = Uri.https("gnews.io", "/api/v4/search", {
      "q": query,
      "apikey": apiKey,
      "lang": "en",
      "max": "20",
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

  Future<List<Article>> changeLung(String query) async {
    final uri = Uri.https("gnews.io", "/api/v4/search", {
      "q": "None",
      "apikey": apiKey,
      "lang": query,
      "country": "Any",
      "max": "20",
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
      "https://gnews.io/api/v4/search?q=Global&lang=ar&apikey=$apiKey",
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

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/moudel/article.dart';
import 'package:news_app/screen/home_screen.dart';

class Newsapiservice {
  const Newsapiservice({required this.client});
  final http.Client client;

  Future<List<Article>> featchArticle() async {
    final uri = Uri.tryParse(
      "https://gnews.io/api/v4/search?q=example&apikey=cadd44b8d5598345dde7f972e3574379",
    );
    try {
      final response = await client.get(uri!);
      if (response.statusCode == 200) {
        final jsondata = jsonDecode(response.body);
        final List<dynamic> article = jsondata["articles"];
        return article.map((e) => Article.fromJson(e as Map<String,dynamic>),).toList();
      }else{
        throw Exception("Failed to load news");
      }
    } catch (e) {
      logger.e(e);
      return [];
    }
  }
}

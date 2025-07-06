import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:news_app/moudel/article.dart';
import 'package:news_app/widget/article_widget.dart';

final logger = Logger();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Article> article = [];
  @override
  void initState() {
    super.initState();
    getAtricle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News", style: Theme.of(context).textTheme.titleLarge),
      ),
      body: ListView.builder(
        itemCount: article.length,
        itemBuilder: (context, index) => ArticleWidget(article: article[index]),
      ),
    );
  }

  void getAtricle() async {
    final url = Uri.parse(
      "https://gnews.io/api/v4/search?q=example&apikey=cadd44b8d5598345dde7f972e3574379",
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsondata = jsonDecode(response.body);
        final List<dynamic> results = jsondata['articles'];
        setState(() {
          article = results
              .map((e) => Article.fromJson(e as Map<String, dynamic>))
              .toList();
        });
      } else {
        logger.e(response.statusCode);
      }
    } catch (e) {
      logger.e(e);
    }
  }
}

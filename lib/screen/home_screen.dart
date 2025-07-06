
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:news_app/provider/article_Notifire.dart';
import 'package:news_app/widget/article_widget.dart';

final logger = Logger();

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(articleProvider.notifier).featchArticle();
  }

  @override
  Widget build(BuildContext context) {
    final article = ref.watch(articleProvider);
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


}

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
  final _query = TextEditingController();
  bool isSearching = false;
  @override
  void initState() {
    super.initState();
    ref.read(articleProvider.notifier).featchArticle();
  }

  @override
  void dispose() {
    super.dispose();
    _query.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final article = ref.watch(articleProvider);
    return Scaffold(
      appBar: AppBar(
        leading: isSearching ?  IconButton(onPressed: () {
          setState(() {
            isSearching = false;
          });
        }, icon: Icon(Icons.arrow_back)):null,
        title: isSearching
            ? SizedBox(
                child: TextField(
                  controller: _query,
                  autofocus: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search news...',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    filled: true,
                    fillColor: Colors.black.withValues(alpha: .1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSubmitted: (value) {
                    if (_query.text.trim().isEmpty) return;
                    ref
                        .read(articleProvider.notifier)
                        .searchArticle(_query.text.trim());
                    setState(() {
                      isSearching = false;
                    });
                  },
                ),
              )
            : Text("News", style: Theme.of(context).textTheme.titleLarge),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearching = true;
              });
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: article.length,
        itemBuilder: (context, index) => ArticleWidget(article: article[index]),
      ),
    );
  }
}

import 'package:connectivity_plus/connectivity_plus.dart';
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
  late final Future<void> provider;
  bool isSearching = false;
  @override
  void initState() {
    super.initState();
    _checkConnection();
    provider = ref.read(articleProvider.notifier).featchArticle();
  }

  @override
  void dispose() {
    super.dispose();
    _query.dispose();
  }

  void _checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No internet connection'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    Widget searchWidget = SizedBox(
      child: TextField(
        key: const ValueKey("input"),
        controller: _query,
        autofocus: true,
        style: const TextStyle(color: Colors.white),
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
          ref.read(articleProvider.notifier).searchArticle(_query.text.trim());
          setState(() {
            isSearching = false;
          });
        },
      ),
    );
    final article = ref.watch(articleProvider);
    return Scaffold(
      appBar: AppBar(
        leading: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: isSearching
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                    });
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                )
              : const SizedBox(width: 0,),
        ),

        title: isSearching
            ? searchWidget
            : Text(
                key: const ValueKey("title"),
                "News",
                style: Theme.of(context).textTheme.titleLarge,
              ),

        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearching = true;
              });
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
           _checkConnection();
          provider = ref.read(articleProvider.notifier).featchArticle();
        },
        child: FutureBuilder(
          future: provider,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }
            return ListView.builder(
              itemCount: article.length,
              itemBuilder: (context, index) =>
                  ArticleWidget(article: article[index]),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/moudel/article.dart';
import 'package:news_app/service/newsapiservice.dart';
import 'package:http/http.dart' as http;

class ArticleProvider extends StateNotifier<List<Article>> {
  ArticleProvider(this.apiservice) : super([]);
  final Newsapiservice apiservice;

  Future<void> featchArticle() async {
    final article = await apiservice.featchArticle();
    state = article;
  }
}
// Provide HTTP Client
final httpClientProvider = Provider<http.Client>((ref) => http.Client());

// Provide the News API Service
final newsApiServiceProvider = Provider<Newsapiservice>((ref) {
  final client = ref.watch(httpClientProvider);
  return Newsapiservice(client: client);
});

// Provide Article Notifier with the News API Service
final articleProvider = StateNotifierProvider<ArticleProvider, List<Article>>((
  ref,
) {
  final apiService = ref.watch(newsApiServiceProvider);
  return ArticleProvider(apiService);
});

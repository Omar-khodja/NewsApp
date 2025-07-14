import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/moudel/article.dart';
import 'package:news_app/screen/home_screen.dart';
import 'package:news_app/widget/article_image.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key, required this.article});
  final Article article;

  void luchuri() async {
    if (article.link != null) {
      final uri = Uri.tryParse(article.link!);
      try {
        await launchUrl(uri!, mode: LaunchMode.externalApplication);
      } catch (e) {
        logger.e(e);
      }
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ArticleImage(title: article.title ?? "no title", image: article.imageurl!),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 5),
              child: Text(
                article.description!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: .8),
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    DateFormat("dd/MM/yyy").format(article.pubDate!),
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(fontSize: 12),
                  ),

                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: luchuri,
                    label: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "reade more",
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.greenAccent,
                          size: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

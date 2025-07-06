import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:news_app/moudel/article.dart';
import 'package:transparent_image/transparent_image.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key, required this.article});
  final Article article;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: InkWell(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Stack(
                children: [
                  FadeInImage(
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                    placeholder: MemoryImage(kTransparentImage),
                    image: article.imageurl != null
                        ? NetworkImage(article.imageurl!)
                        : MemoryImage(kTransparentImage),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 90,
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      color: Colors.black87,
                      child: Text(
                        article.title!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 18,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8.0,8,8,5),
                child: Text(
                  article.description!,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: .8),
                  ),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "reade more",
                        style: TextStyle(color: Colors.greenAccent,fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(width: 5),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.greenAccent,
                        size: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

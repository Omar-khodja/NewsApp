import 'dart:math';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ArticleImage extends StatelessWidget {
  const ArticleImage({super.key, required this.title, required this.image});
  final String title;
  final String image;
  @override
  Widget build(BuildContext context) {
    print(image);
    return Stack(
      children: [
        FadeInImage(
          width: double.infinity,
          height: 250,
          fit: BoxFit.cover,
          placeholder: MemoryImage(kTransparentImage),
          image: NetworkImage(image),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 90,
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            color: Colors.black87,
            child: Text(
              title ,
              textAlign: TextAlign.center,
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
    );
  }
}

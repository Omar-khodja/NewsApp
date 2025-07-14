import 'package:hive/hive.dart';


@HiveType(typeId: 0)
class ArticleModel extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String imageurl;

  @HiveField(3)
  final String link;

  ArticleModel({
    required this.title,
    required this.description,
    required this.imageurl,
    required this.link,
  });
}

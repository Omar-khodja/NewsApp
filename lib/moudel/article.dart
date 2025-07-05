
class Article {
  String? id;
  String? title;
  String? link;
  DateTime? pubDate;
  String? imageurl;
  String? category;
  String? aitag;
  Article({
    required this.id,
    required this.title,
    required this.category,
    required this.imageurl,
    required this.link,
    required this.pubDate,
    required this.aitag,
  });
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json["article_id"] as String?,
      title: json["title"] as String?,
      category: (json["category"] != null && json["category"].isNotEmpty)
          ? json["category"][0] as String?
          : null,
      imageurl: json["image_url"] as String?,
      link: json["link"] as String?,
      pubDate: json["pubDate"] != null
          ? DateTime.tryParse(json["pubDate"])
          : null,
      aitag: (json["ai_tag"] != null && json["ai_tag"].isNotEmpty)
          ? json["ai_tag"][0] as String?
          : null,
    );
  }
}

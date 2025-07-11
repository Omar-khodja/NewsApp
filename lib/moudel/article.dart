class Article {
  final String? title;
  final String? description;
  final String? content;
  final String? link;
  final String? imageurl;
  final DateTime? pubDate;
  Article({
    required this.title,
    required this.description,
    required this.imageurl,
    required this.link,
    required this.pubDate,
    required this.content,
  });
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json["title"] as String?,
      description: json["description"] as String?,
      imageurl: json["image"] as String?,
      link: json["url"] as String?,
      pubDate: json["publishedAt"] != null
          ? DateTime.tryParse(json["publishedAt"])
          : null,
      content: json["content"] as String?,
    );
  }
}

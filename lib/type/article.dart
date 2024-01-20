class Article {
  final int id;
  final String guid;
  final String title;
  final String link;
  // final List<String> labels;
  final bool unread;
  final bool marked;
  final bool published;
  final String comments;
  final String author;
  final int updated;
  final int feed_id;
  // final List<String> attachments;
  final int score;
  final String feed_title;
  //note lang
  final String content;

  Article(
      {required this.id,
      required this.guid,
      required this.title,
      required this.link,
      // required this.labels,
      required this.unread,
      required this.marked,
      required this.published,
      required this.comments,
      required this.author,
      required this.updated,
      required this.feed_id,
      // required this.attachments,
      required this.score,
      required this.feed_title,
      required this.content});

  //tags labels feed_title comments_count comments_link
  //always_display_attachments author score note lang site_url

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json["id"],
      guid: json["guid"],
      title: json["title"],
      link: json["link"],
      // labels: json["labels"],
      unread: json["unread"],
      marked: json["marked"],
      published: json["published"],
      comments: json["comments"],
      author: json["author"],
      updated: json["updated"],
      feed_id: json["feed_id"],
      // attachments: json["attachments"],
      score: json["score"],
      feed_title: json["feed_title"],
      content: json["content"],
    );
  }
}

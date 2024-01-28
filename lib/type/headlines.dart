class Headline {
  final int id;
  final String guid;
  bool unread;
  final bool marked;
  final bool published;
  final int updated;
  final bool is_updated;
  final String title;
  final String link;
  final int feed_id;
  final String excerpt;

  Headline({
    required this.id,
    required this.guid,
    required this.unread,
    required this.marked,
    required this.published,
    required this.updated,
    required this.is_updated,
    required this.title,
    required this.link,
    required this.feed_id,
    required this.excerpt,
  });
  //tags labels feed_title comments_count comments_link
  //always_display_attachments author score note lang site_url

  factory Headline.fromJson(Map<String, dynamic> json) {
    return Headline(
      id: json["id"],
      guid: json["guid"],
      unread: json["unread"],
      marked: json["marked"],
      published: json["published"],
      updated: json["updated"],
      is_updated: json["is_updated"],
      title: json["title"],
      link: json["link"],
      feed_id: json["feed_id"],
      excerpt: json['excerpt'],
    );
  }
}

// class Headlines {
//   final int seq;
//   final int status;
//   final List<Headline> content;

//   Headlines({required this.seq, required this.status, required this.content});

//   factory Headlines.fromJson(Map<String, dynamic> json) {
//     var list = json['content'] as List;
//     List<Headline> headlineList =
//         list.map((i) => Headline.fromJson(i)).toList();
//     return Headlines(
//         seq: json["seq"], status: json["status"], content: headlineList);
//   }
// }

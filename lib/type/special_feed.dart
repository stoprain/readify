class SpecialFeed {
  final String? feed_url;
  final String title;
  final int id;
  final int unread;
  final bool? has_icon;
  final int cat_id;
  final int? last_updated;
  final int? order_id;

  SpecialFeed(
      {required this.feed_url,
      required this.title,
      required this.id,
      required this.unread,
      required this.has_icon,
      required this.cat_id,
      required this.last_updated,
      required this.order_id});

  factory SpecialFeed.fromJson(Map<String, dynamic> json) {
    return SpecialFeed(
      feed_url: json["feed_url"],
      title: json["title"],
      id: json["id"],
      unread: json["unread"],
      has_icon: json["has_icon"],
      cat_id: json["cat_id"],
      last_updated: json["last_updated"],
      order_id: json["order_id"],
    );
  }
}

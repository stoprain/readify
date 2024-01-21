//https://tt-rss.org/wiki/ApiReference#getcategories

class Category {
  final int id;
  final String title;
  final int unread;
  final int order_id;

  Category(
      {required this.id,
      required this.title,
      required this.unread,
      required this.order_id});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json["id"],
        title: json["title"],
        unread: json["unread"],
        order_id: json["order_id"] ?? 0);
  }
}

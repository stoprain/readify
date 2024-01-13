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

  // factory Category.fromJson(Map<String, dynamic> json) => Category(
  //       id: json["id"],
  //       title: json["title"],
  //       unread: json["unread"],
  //       order_id: json["order_id"],
  //     );

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json["id"],
        title: json["title"],
        unread: json["unread"],
        order_id: json["order_id"] ?? 0);
  }

  // (
  //     id: json["id"],
  //     title: json["title"],
  //     unread: json["unread"],
  //     order_id: json["order_id"],
  //   );

  // factory Category.fromJson(Map<String, dynamic> json) {
  //   return switch (json) {
  //     {
  //       'id': int id,
  //       'title': String title,
  //       'unread': int unread,
  //       'order_id': int order_id,
  //     } =>
  //       Category(
  //         id: id,
  //         title: title,
  //         unread: unread,
  //         order_id: order_id,
  //       ),
  //     _ => throw const FormatException('Failed to load Category.'),
  //   };
  // }
}

class Categories {
  final int seq;
  final int status;
  final List<Category> content;

  Categories({required this.seq, required this.status, required this.content});

  factory Categories.fromJson(Map<String, dynamic> json) {
    var list = json['content'] as List;
    List<Category> categoryList =
        list.map((i) => Category.fromJson(i)).toList();
    return Categories(
        seq: json["seq"], status: json["status"], content: categoryList);
    // seq: json["seq"],
    // status: json["status"],
    // content: Category.fromJson(json["content"]),
  }

  // factory Categories.fromJson(Map<String, dynamic> json) {
  //   return switch (json) {
  //     {
  //       'seq': int seq,
  //       'status': int status,
  //       'content': Category content,
  //     } =>
  //       Categories(
  //           seq: seq,
  //           status: status,
  //           content: Category.fromJson(json['content'])),
  //     _ => throw const FormatException('Failed to load Category.'),
  //   };
  // }
}

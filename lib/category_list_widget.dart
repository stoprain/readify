import 'package:flutter/material.dart';

import 'type/categories.dart';

class CategoryListWidget extends StatelessWidget {
  final List<Category> categories;
  const CategoryListWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          var unread = categories[index].unread;
          return Row(
            children: [Text(categories[index].title), Text('unread $unread')],
          );
        });
  }
}

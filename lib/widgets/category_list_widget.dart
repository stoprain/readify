import 'package:flutter/material.dart';
import 'package:tinyreader/screens/feeds_screen.dart';

import '../type/categories.dart';

class CategoryListWidget extends StatelessWidget {
  final List<Category> categories;
  const CategoryListWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          var category = categories[index];
          var unread = category.unread;
          var title = category.title;
          return Row(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FeedsScreen(
                                  category: category,
                                )));
                  },
                  child: Text(title)),
              Text('unread $unread'),
            ],
          );
        });
  }
}

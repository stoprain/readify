import 'package:flutter/material.dart';
import 'package:readify/screens/feeds_screen.dart';

import '../type/category.dart';

class CategoryListWidget extends StatelessWidget {
  final List<Category> categories;
  const CategoryListWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: categories.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          var category = categories[index];
          var unread = category.unread;
          var title = category.title;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
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

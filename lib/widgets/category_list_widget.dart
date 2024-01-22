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
        separatorBuilder: (BuildContext context, int index) => const Divider(
              height: 1,
            ),
        itemBuilder: (BuildContext context, int index) {
          var category = categories[index];
          var unread = category.unread;
          var title = category.title;
          return InkWell(
            child: Container(
              constraints: const BoxConstraints(
                  minHeight: 40, minWidth: double.infinity, maxHeight: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(title),
                  Text('unread $unread'),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FeedsScreen(
                            category: category,
                          )));
            },
          );
        });
  }
}

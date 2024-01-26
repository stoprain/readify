import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:readify/screens/feeds_screen.dart';
import 'package:readify/widgets/title_cell_widget.dart';

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
          return TitleCellWidget(
              icon: const Icon(
                Icons.folder_outlined,
                size: 18,
              ),
              title: title,
              unread: unread,
              onCellTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoaderOverlay(
                              child: FeedsScreen(
                                category: category,
                              ),
                            )));
              });
        });
  }
}

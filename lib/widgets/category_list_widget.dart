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
        separatorBuilder: (BuildContext context, int index) {
          if (index == 0 || index == categories.length - 2) {
            return const Column(
              children: [
                Divider(
                  height: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 1,
                )
              ],
            );
          }
          return const Divider(
            height: 1,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          var category = categories[index];
          var unread =
              (category.id > 0 || category.unread > 0) ? category.unread : -1;
          var title = category.title;
          return TitleCellWidget(
              icon: category.id <= 0
                  ? const Icon(
                      Icons.tag,
                      size: 18,
                      color: Colors.blue,
                    )
                  : const Icon(
                      Icons.folder_outlined,
                      size: 18,
                      color: Colors.blue,
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

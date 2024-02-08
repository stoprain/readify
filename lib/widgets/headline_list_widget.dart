import 'package:flutter/material.dart';
import 'package:readify/type/headline.dart';
import 'package:readify/widgets/headline_cell_widget.dart';

class HeadlineListWidget extends StatelessWidget {
  final String feedTitle;
  final List<Headline> headlines;
  const HeadlineListWidget(
      {super.key, required this.headlines, required this.feedTitle});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: headlines.length + 1,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                feedTitle,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            );
          }
          var headline = headlines[index - 1];
          return HeadlineCellWidget(
            headline: headline,
          );
        });
  }
}

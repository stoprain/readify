import 'package:flutter/material.dart';
import 'package:readify/type/headlines.dart';
import 'package:readify/widgets/headline_cell_widget.dart';

class HeadlineListWidget extends StatelessWidget {
  final List<Headline> headlines;
  const HeadlineListWidget({super.key, required this.headlines});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: headlines.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          var headline = headlines[index];
          return HeadlineCellWidget(
            headline: headline,
          );
        });
  }
}

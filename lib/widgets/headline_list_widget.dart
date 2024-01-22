import 'package:flutter/material.dart';
import 'package:readify/screens/article_screen.dart';
import 'package:readify/type/headlines.dart';

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
          var excerpt = headline.excerpt;
          var title = headline.title;
          var updated =
              DateTime.fromMillisecondsSinceEpoch(headline.updated * 1000);
          return InkWell(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(title),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      excerpt,
                      softWrap: true,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      updated.toString(),
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ArticleScreen(
                            headline: headline,
                          )));
            },
          );
        });
  }
}

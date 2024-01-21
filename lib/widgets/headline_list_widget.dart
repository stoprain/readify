import 'package:flutter/material.dart';
import 'package:readify/screens/article_screen.dart';
import 'package:readify/screens/headlines_screen.dart';
import 'package:readify/type/feeds.dart';
import 'package:readify/type/headlines.dart';

class HeadlineListWidget extends StatelessWidget {
  final List<Headline> headlines;
  const HeadlineListWidget({super.key, required this.headlines});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: headlines.length,
        itemBuilder: (BuildContext context, int index) {
          var headline = headlines[index];
          var unread = headline.unread;
          var excerpt = headline.excerpt;
          var title = headline.title;
          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ArticleScreen(
                                    headline: headline,
                                  )));
                    },
                    child: Text(title)),
              ),
              Text(
                excerpt,
                softWrap: true,
              ),
            ],
          );
          // return Row(
          //   children: [

          //     Text('unread $unread'),
          //   ],
          // );
        });
  }
}

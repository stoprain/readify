import 'package:flutter/material.dart';
import 'package:tinyreader/screens/article_screen.dart';
import 'package:tinyreader/screens/headlines_screen.dart';
import 'package:tinyreader/type/feeds.dart';
import 'package:tinyreader/type/headlines.dart';

class HeadlineListWidget extends StatelessWidget {
  final List<Headline> headlines;
  const HeadlineListWidget({super.key, required this.headlines});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: headlines.length,
        itemBuilder: (BuildContext context, int index) {
          var headline = headlines[index];
          var unread = headline.unread;
          var title = headline.title;
          return Row(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ArticleScreen(
                                  headline: headline,
                                )));
                  },
                  child: Text(title)),
              Text('unread $unread'),
            ],
          );
        });
  }
}

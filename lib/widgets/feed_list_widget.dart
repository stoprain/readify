import 'package:flutter/material.dart';
import 'package:readify/screens/headlines_screen.dart';
import 'package:readify/type/feeds.dart';

class FeedListWidget extends StatelessWidget {
  final List<Feed> feeds;
  const FeedListWidget({super.key, required this.feeds});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: feeds.length,
        itemBuilder: (BuildContext context, int index) {
          var feed = feeds[index];
          var unread = feed.unread;
          var title = feed.title;
          return Row(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HeadlinesScreen(
                                  feed: feed,
                                )));
                  },
                  child: Text(title)),
              Text('unread $unread'),
            ],
          );
        });
  }
}

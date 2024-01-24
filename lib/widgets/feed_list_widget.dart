import 'package:flutter/material.dart';
import 'package:readify/screens/headlines_screen.dart';
import 'package:readify/type/feeds.dart';
import 'package:readify/widgets/title_cell_widget.dart';

class FeedListWidget extends StatelessWidget {
  final List<Feed> feeds;
  const FeedListWidget({super.key, required this.feeds});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: feeds.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(
              height: 1,
            ),
        itemBuilder: (BuildContext context, int index) {
          var feed = feeds[index];
          var unread = feed.unread;
          var title = feed.title;
          return TitleCellWidget(
              icon: const Icon(Icons.newspaper),
              title: title,
              unread: unread,
              onCellTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HeadlinesScreen(
                              feed: feed,
                            )));
              });
        });
  }
}

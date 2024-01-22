import 'package:flutter/material.dart';
import 'package:readify/screens/headlines_screen.dart';
import 'package:readify/type/feeds.dart';
import 'package:readify/util/network.dart';

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
          return InkWell(
            child: Container(
              constraints: const BoxConstraints(
                  minHeight: 40, minWidth: double.infinity, maxHeight: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: Image.network(
                          Network.getIco(feed.id),
                          errorBuilder: (context, error, stackTrace) {
                            return Text('ICO');
                          },
                        ),
                      ),
                      Text(title),
                    ],
                  ),
                  Text('unread $unread'),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HeadlinesScreen(
                            feed: feed,
                          )));
            },
          );
        });
  }
}

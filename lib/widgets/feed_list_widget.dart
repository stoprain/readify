import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:readify/screens/headlines_screen.dart';
import 'package:readify/type/feeds.dart';
import 'package:readify/util/network.dart';
import 'package:readify/widgets/title_cell_widget.dart';

class FeedListWidget extends StatelessWidget {
  final String categoryTitle;
  final List<Feed> feeds;
  const FeedListWidget(
      {super.key, required this.feeds, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: feeds.length + 1,
        separatorBuilder: (BuildContext context, int index) => const Divider(
              height: 1,
            ),
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                categoryTitle,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            );
          }
          var feed = feeds[index - 1];
          var unread = feed.unread;
          var title = feed.title;
          return TitleCellWidget(
              icon: Image.network(
                Network.getIco(feed.id),
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.newspaper,
                    size: 18,
                    color: Colors.blue,
                  );
                },
              ),
              title: title,
              unread: unread,
              onCellTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoaderOverlay(
                              child: HeadlinesScreen(
                                feed: feed,
                              ),
                            )));
              });
        });
  }
}

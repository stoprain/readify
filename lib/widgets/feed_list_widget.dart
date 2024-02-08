import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:readify/screens/headlines_screen.dart';
import 'package:readify/type/category.dart';
import 'package:readify/type/feed.dart';
import 'package:readify/util/network.dart';
import 'package:readify/widgets/title_cell_widget.dart';

class FeedListWidget extends StatelessWidget {
  final Category category;
  final List<Feed> feeds;
  const FeedListWidget(
      {super.key, required this.category, required this.feeds});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: feeds.length + 1,
        separatorBuilder: (BuildContext context, int index) => const Divider(
              height: 1,
            ),
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      category.title,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                TitleCellWidget(
                  icon: const Icon(
                    Icons.tag,
                    size: 18,
                    color: Colors.blue,
                  ),
                  title: 'All articles',
                  unread: feeds.firstOrNull != null
                      ? feeds
                          .map((e) => e.unread)
                          .reduce((value, element) => value + element)
                      : 0,
                  onCellTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoaderOverlay(
                                child: HeadlinesScreen(
                                    catOrFeedId: category.id,
                                    title: category.title,
                                    isCat: true))));
                  },
                ),
              ],
            );
          }
          var feed = feeds[index - 1];
          var unread = feed.unread;
          var title = feed.title;
          return TitleCellWidget(
              icon: CachedNetworkImage(
                imageUrl: Network.getIco(feed.id),
                errorWidget: (context, url, error) {
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
                                catOrFeedId: feed.id,
                                title: title,
                                isCat: false))));
              });
        });
  }
}

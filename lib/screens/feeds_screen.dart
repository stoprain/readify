import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:readify/type/category.dart';
import 'package:readify/type/feeds.dart';
import 'package:readify/util/network.dart';
import 'package:readify/widgets/feed_list_widget.dart';

class FeedsScreen extends StatefulWidget {
  final Category category;
  const FeedsScreen({super.key, required this.category});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  List<Feed> feeds = [];
  bool isUnread = true;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {
    context.loaderOverlay.show();
    Network.getFeeds(widget.category.id, isUnread).then((value) => {
          setState(() {
            feeds = value;
            context.loaderOverlay.hide();
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
        actions: [
          SegmentedButton(
            segments: const [
              ButtonSegment(value: true, label: Text('Unread')),
              ButtonSegment(value: false, label: Text('All'))
            ],
            selected: {isUnread},
            onSelectionChanged: (i) => {
              setState(() {
                isUnread = i.first;
                refresh();
              })
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.refresh_rounded,
            ),
            onPressed: () {
              refresh();
            },
          ),
        ],
      ),
      body: FeedListWidget(feeds: feeds),
    );
  }
}

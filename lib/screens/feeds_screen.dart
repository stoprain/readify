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
        title: Text(
          widget.category.title,
        ),
        centerTitle: false,
        actions: [
          SegmentedButton(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment(value: true, label: Text('U')),
              ButtonSegment(value: false, label: Text('A'))
            ],
            selected: {isUnread},
            onSelectionChanged: (i) => {
              setState(() {
                isUnread = i.first;
                refresh();
              })
            },
            style: const ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            ),
          ),
          // IconButton(
          //   icon: const Icon(
          //     Icons.refresh_rounded,
          //   ),
          //   onPressed: () {
          //     refresh();
          //   },
          // ),
        ],
      ),
      body: FeedListWidget(feeds: feeds),
    );
  }
}

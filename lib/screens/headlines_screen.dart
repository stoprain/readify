import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:readify/type/feeds.dart';
import 'package:readify/type/headlines.dart';
import 'package:readify/util/network.dart';
import 'package:readify/widgets/headline_list_widget.dart';

class HeadlinesScreen extends StatefulWidget {
  final Feed feed;
  const HeadlinesScreen({super.key, required this.feed});

  @override
  State<HeadlinesScreen> createState() => _HeadlinesScreenState();
}

class _HeadlinesScreenState extends State<HeadlinesScreen> {
  List<Headline> headlines = [];
  bool isUnread = true;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {
    context.loaderOverlay.show();
    Network.getHeadlines(widget.feed.id, isUnread).then((value) => {
          setState(() {
            headlines = value;
            context.loaderOverlay.hide();
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.feed.title,
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
      body: HeadlineListWidget(headlines: headlines),
    );
  }
}

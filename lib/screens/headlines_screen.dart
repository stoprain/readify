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

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {
    context.loaderOverlay.show();
    Network.getHeadlines(widget.feed.id).then((value) => {
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
        title: Text(widget.feed.title),
        actions: [
          // Icon(Icons.refresh_rounded),
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
      body: HeadlineListWidget(headlines: headlines),
    );
  }
}

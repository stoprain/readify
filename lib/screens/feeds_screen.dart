import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:readify/type/category.dart';
import 'package:readify/type/feeds.dart';
import 'package:readify/util/network.dart';
import 'package:readify/util/preference.dart';
import 'package:readify/widgets/feed_list_widget.dart';
import 'package:readify/widgets/unread_switch_widget.dart';

class FeedsScreen extends StatefulWidget {
  final Category category;
  const FeedsScreen({super.key, required this.category});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  List<Feed> feeds = [];

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {
    context.loaderOverlay.show();
    Network.getFeeds(
            widget.category.id, Preference.getBool(Preference.UNREAD) ?? true)
        .then((value) => {
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
        title: UnreadSwitchWidget(
          onChange: () {
            refresh();
          },
        ),
        centerTitle: false,
        actions: [
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
      body: FeedListWidget(
        feeds: feeds,
        categoryTitle: widget.category.title,
      ),
    );
  }
}

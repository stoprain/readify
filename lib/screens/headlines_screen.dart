import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:readify/type/headline.dart';
import 'package:readify/util/network.dart';
import 'package:readify/util/preference.dart';
import 'package:readify/widgets/headline_list_widget.dart';
import 'package:readify/widgets/unread_switch_widget.dart';

class HeadlinesScreen extends StatefulWidget {
  // final Feed feed;
  final int catOrFeedId;
  final String title;
  final bool isCat;
  const HeadlinesScreen(
      {super.key,
      required this.catOrFeedId,
      required this.title,
      required this.isCat});

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
    Network.getHeadlines(widget.catOrFeedId, widget.isCat,
            Preference.getBool(Preference.UNREAD) ?? true)
        .then((value) => {
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
          IconButton(
            icon: const Icon(
              Icons.check,
            ),
            onPressed: () {
              confirm(context).then((value) {
                if (value) {
                  context.loaderOverlay.show();
                  Network.catchupFeed(widget.catOrFeedId, widget.isCat)
                      .then((value) {
                    context.loaderOverlay.hide();
                    for (var h in headlines) {
                      h.unread = false;
                    }
                    setState(() {
                      headlines = headlines;
                    });
                  });
                }
              });
            },
          ),
        ],
      ),
      body: HeadlineListWidget(
        headlines: headlines,
        feedTitle: widget.title,
      ),
    );
  }
}

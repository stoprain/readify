import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:readify/type/feeds.dart';
import 'package:readify/type/headlines.dart';
import 'package:readify/widgets/feed_list_widget.dart';
import 'package:readify/widgets/headline_list_widget.dart';

import '../util/preference.dart';
import 'package:http/http.dart' as http;

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
    var api = Preference.getString(Preference.API) ?? '';
    var sid = Preference.getString(Preference.SID) ?? '';
    http
        .post(Uri.parse(api),
            body: jsonEncode(<String, dynamic>{
              "sid": sid,
              "op": "getHeadlines",
              "feed_id": widget.feed.id,
              "unread_only": true,
              "show_excerpt": true,
              "excerpt_length": 300,
              "view_mode": "unread",
              "order_by": "feed_dates",
            }))
        .then((respsone) {
      setState(() {
        headlines = Headlines.fromJson(jsonDecode(respsone.body)).content;
      });
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
            icon: Icon(
              Icons.refresh_rounded,
            ),
            onPressed: () {
              refresh();
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search),
          ),
          Icon(Icons.more_vert),
        ],
      ),
      body: Container(
        child: HeadlineListWidget(headlines: headlines),
      ),
    );
  }
}

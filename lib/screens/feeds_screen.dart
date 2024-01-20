import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tinyreader/type/category.dart';
import 'package:tinyreader/type/feeds.dart';
import 'package:tinyreader/widgets/feed_list_widget.dart';

import '../util/preference.dart';
import 'package:http/http.dart' as http;

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
    var api = Preference.getString(Preference.API) ?? '';
    var sid = Preference.getString(Preference.SID) ?? '';
    http
        .post(Uri.parse(api),
            body: jsonEncode(<String, dynamic>{
              "sid": sid,
              "op": "getFeeds",
              "cat_id": widget.category.id,
              "unread_only": true,
            }))
        .then((respsone) {
      setState(() {
        feeds = Feeds.fromJson(jsonDecode(respsone.body)).content;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search),
          ),
          Icon(Icons.more_vert),
        ],
      ),
      body: Container(
        child: FeedListWidget(feeds: feeds),
      ),
    );
  }
}

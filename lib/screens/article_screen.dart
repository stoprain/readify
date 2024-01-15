import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tinyreader/type/articles.dart';
import 'package:tinyreader/type/feeds.dart';
import 'package:tinyreader/type/headlines.dart';
import 'package:tinyreader/widgets/feed_list_widget.dart';
import 'package:tinyreader/widgets/headline_list_widget.dart';

import '../util/preference.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ArticleScreen extends StatefulWidget {
  final Headline headline;
  const ArticleScreen({super.key, required this.headline});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  Article? article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.headline.title),
        actions: [
          // Icon(Icons.refresh_rounded),
          IconButton(
            icon: Icon(
              Icons.refresh_rounded,
            ),
            onPressed: () {
              var api = Preference.getString(Preference.API) ?? '';
              var sid = Preference.getString(Preference.SID) ?? '';
              http
                  .post(Uri.parse(api),
                      body: jsonEncode(<String, dynamic>{
                        "sid": sid,
                        "op": "getArticle",
                        "article_id": widget.headline.id
                      }))
                  .then((respsone) {
                setState(() {
                  article =
                      Articles.fromJson(jsonDecode(respsone.body)).content[0];
                });
              });
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
        child: HtmlWidget(article?.content ?? ''),
      ),
    );
  }
}

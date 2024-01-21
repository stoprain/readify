import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:readify/type/article.dart';
import 'package:readify/type/headlines.dart';
import 'package:readify/util/network.dart';

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
  void initState() {
    refresh();
    super.initState();
  }

  refresh() async {
    var temp = await Network.getArticle(widget.headline.id);
    setState(() {
      article = temp;
    });
    Network.updateArticle(widget.headline.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.headline.title),
          actions: [],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[HtmlWidget(article?.content ?? '')],
          ),
        ));
  }
}

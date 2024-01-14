import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tinyreader/type/categories.dart';

import 'util/preference.dart';
import 'package:http/http.dart' as http;

class FeedsScreen extends StatefulWidget {
  final Category category;
  const FeedsScreen({super.key, required this.category});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
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
                        "op": "getFeeds",
                        "cat_id": widget.category.id,
                        "unread_only": true,
                      }))
                  .then((respsone) {
                setState(() {
                  // categories =
                  //     Categories.fromJson(jsonDecode(respsone.body)).content;
                  var test = respsone.body;
                  print(test);
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
    );
  }
}

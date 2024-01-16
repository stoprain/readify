import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tinyreader/widgets/category_list_widget.dart';
import 'package:tinyreader/screens/setting_screen.dart';
import 'package:tinyreader/util/preference.dart';

import '../type/categories.dart';

import 'package:http/http.dart' as http;

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  List<Category> categories = [];

  @override
  void initState() {
    Preference.load();
    super.initState();
  }

  void refresh() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.settings,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SettingScreen()));
          },
        ),
        title: Text('Subscriptions'),
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
                      body: jsonEncode(
                          <String, String>{"sid": sid, "op": "getCategories"}))
                  .then((respsone) {
                setState(() {
                  categories =
                      Categories.fromJson(jsonDecode(respsone.body)).content;
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
        child: CategoryListWidget(categories: categories),
      ),
    );
  }
}

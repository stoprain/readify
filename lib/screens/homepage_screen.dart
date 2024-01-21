import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:readify/util/network.dart';
import 'package:readify/widgets/category_list_widget.dart';
import 'package:readify/screens/setting_screen.dart';
import 'package:readify/util/preference.dart';

import '../type/category.dart';

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
            onPressed: () async {
              var temp = await Network.getCategories();
              setState(() {
                categories = temp;
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

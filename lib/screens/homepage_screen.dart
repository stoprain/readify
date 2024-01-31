import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:readify/util/network.dart';
import 'package:readify/widgets/category_list_widget.dart';
import 'package:readify/screens/setting_screen.dart';
import 'package:readify/util/preference.dart';

import '../type/category.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  List<Category> categories = [];

  @override
  initState() {
    Preference.load().then((value) => {refresh()});
    super.initState();
  }

  refresh() {
    context.loaderOverlay.show();
    Network.getCategories().then((value) => {
          setState(() {
            for (var i = 0; i < value.length; i++) {
              if (value[i].id == -1) {
                final Category first = value.removeAt(i);
                value.insert(0, first);
              }
            }
            categories = value;
            context.loaderOverlay.hide();
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.settings,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SettingScreen()));
          },
        ),
        title: const Text('Subscriptions'),
        centerTitle: false,
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
      body: CategoryListWidget(categories: categories),
    );
  }
}

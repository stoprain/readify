import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

class GloabalSnackBar {
  static void show(String body) {
    final SnackBar snackBar = SnackBar(content: Text(body));
    snackbarKey.currentState?.showSnackBar(snackBar);
  }
}

import 'package:flutter/material.dart';
import 'package:readify/screens/homepage_screen.dart';
import 'package:readify/util/globals.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Readify',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 44, 44, 46)),
        useMaterial3: true,
      ),
      home: const MyHomeScreen(),
      scaffoldMessengerKey: snackbarKey,
    );
  }
}

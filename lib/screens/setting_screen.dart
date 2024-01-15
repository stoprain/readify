import 'package:flutter/material.dart';

import '../util/preference.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  String _api = '';
  String _user = '';
  String _pass = '';
  final _apiText = TextEditingController();
  final _userText = TextEditingController();
  final _passText = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _api = Preference.getString(Preference.API) ?? '';
      _user = Preference.getString(Preference.USER) ?? '';
      _pass = Preference.getString(Preference.PASS) ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
          child: Column(
        children: [
          const Text('api address'),
          StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            _apiText.text = _api;
            return TextField(
              controller: _apiText,
            );
          }),
          const Text('user'),
          StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            _userText.text = _user;
            return TextField(
              controller: _userText,
            );
          }),
          const Text('pass'),
          StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            _passText.text = _pass;
            return TextField(
              controller: _passText,
            );
          }),
          ElevatedButton(
            onPressed: () {
              Preference.setString(Preference.API, _apiText.text);
              Preference.setString(Preference.USER, _userText.text);
              Preference.setString(Preference.PASS, _passText.text);
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      )),
    );
  }
}

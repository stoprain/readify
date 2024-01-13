import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String KEY_API = 'api';
const String KEY_USER = 'user';
const String KEY_PASS = 'pass';
const String KEY_SID = 'sid';

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
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _api = prefs.getString(KEY_API) ?? '';
      _user = prefs.getString(KEY_USER) ?? '';
      _pass = prefs.getString(KEY_PASS) ?? '';
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
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString(KEY_API, _apiText.text);
              await prefs.setString(KEY_USER, _userText.text);
              await prefs.setString(KEY_PASS, _passText.text);
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
